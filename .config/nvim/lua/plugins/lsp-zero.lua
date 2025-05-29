local has_words_before = function()
	local cursor = vim.api.nvim_win_get_cursor(0)
	return (vim.api.nvim_buf_get_lines(0, cursor[1] - 1, cursor[1], true)[1] or ''):sub(cursor[2], cursor[2])
	    :match('%s')
end

return { -- Install lsp-zero and its dependencies
	{
		'VonHeikemen/lsp-zero.nvim',
		branch = 'v2.x',
		dependencies = { 'neovim/nvim-lspconfig', -- LSP Config
			'williamboman/mason.nvim', -- Mason to install LSP servers
			'williamboman/mason-lspconfig.nvim', -- Mason integration with lspconfig
			'hrsh7th/nvim-cmp', -- Completion plugin
			'hrsh7th/cmp-nvim-lsp', -- LSP completion source
			'saadparwaiz1/cmp_luasnip', -- Snippet completion
			'L3MON4D3/LuaSnip', -- Snippet engine
			'hashicorp/terraform-ls' },
		config = function()
			local lsp = require('lsp-zero')

			-- Basic lsp-zero setup
			lsp.preset('recommended') -- Use the recommended preset

			-- Configure LSP servers
			lsp.ensure_installed({ 'ts_ls', -- TypeScript/JavaScript (ts_ls instead of tsserver)
				'eslint', -- JavaScript & TypeScript linter
				'dockerls', -- Docker
				'marksman', -- Markdown
				'html', -- HTML (optional for React)
				'cssls', -- CSS (optional for React)
				'jsonls', -- JSON (optional for React)
				'lua_ls', -- Lua Language Server (lua_ls)
				'terraformls',
				'tailwindcss',
			})

			-- Configure Lua LSP (lua_ls)
			require('lspconfig').lua_ls.setup({
				settings = {
					Lua = {
						diagnostics = {
							-- Get the language server to recognize the `vim` global
							globals = { 'vim' }
						},
						workspace = {
							-- Make the server aware of Neovim runtime files
							library = vim.api.nvim_get_runtime_file("", true)
						},
						-- Enable formatting (you can disable this if you prefer to use other formatters)
						format = {
							enable = true
						}
					}
				}
			})

			-- LSP settings
			lsp.on_attach(function(client, bufnr)
				local opts = {
					buffer = bufnr
				}
				local buf = vim.lsp.buf
				local diag = vim.diagnostic

				-- Keybindings for LSP features
				vim.keymap.set('n', 'K', buf.hover, opts)
				vim.keymap.set('n', 'gd', buf.definition, opts)
				vim.keymap.set('n', 'gD', buf.declaration, opts)
				vim.keymap.set('n', 'gi', buf.implementation, opts)
				vim.keymap.set('n', 'go', buf.type_definition, opts)
				vim.keymap.set('n', 'gr', buf.references, opts)
				vim.keymap.set('n', 'gs', buf.signature_help, opts)
				vim.keymap.set('n', '<F2>', buf.rename, opts)
				vim.keymap.set({ 'n', 'x' }, '<F3>', function()
					buf.format({
						async = true
					})
				end, opts)
				vim.keymap.set('n', '<F4>', buf.code_action, opts)

				-- Diagnostic mappings
				vim.keymap.set("n", "<space>d", function()
					buf.workspace_symbol(vim.fn.input("Query > "))
				end, opts)
				vim.keymap.set("n", "<leader>vd", diag.open_float, opts)
				vim.keymap.set("n", "<leader>ac", buf.code_action, opts)
				vim.keymap.set("n", "[d", diag.goto_next, opts)
				vim.keymap.set("n", "]d", diag.goto_prev, opts)
			end)

			-- Set up auto-completion (nvim-cmp)
			local cmp = require('cmp')

			local cmp_mappings = lsp.defaults.cmp_mappings({
				['<C-n>'] = cmp.mapping.select_next_item(),
				['<C-p>'] = cmp.mapping.select_prev_item(),
				['<C-d>'] = cmp.mapping.scroll_docs(-4),
				['<C-u>'] = cmp.mapping.scroll_docs(4),
				['<CR>'] = cmp.mapping.confirm({
					select = true
				}),
				['<S-Space>'] = cmp.mapping.complete(),
				['<Tab>'] = cmp.mapping(function(fallback)
					local suggestion = require("copilot.suggestion")
					if suggestion.is_visible() then
						suggestion.accept()
					elseif cmp.visible() then
						cmp.confirm({
							select = true
						})
					elseif has_words_before() then
						cmp.complete()
					else
						fallback()
					end
				end, { "i", "c" })
			})

			local cmp_opts = {
				sources = { {
					name = 'nvim_lsp'
				}, {
					name = 'luasnip'
				} },
				snippet = {
					expand = function(args)
						require('luasnip').snippet_expand(args.body)
					end
				},
				mapping = cmp_mappings
			}

			cmp.setup(cmp_opts)

			-- Finalize setup for LSPs
			lsp.setup()
		end
	} }
