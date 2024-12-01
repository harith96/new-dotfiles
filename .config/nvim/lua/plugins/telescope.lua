return {
	'nvim-telescope/telescope.nvim',
	version = '0.1.8', -- Use specific version if necessary
	dependencies = { 'nvim-lua/plenary.nvim' },
	opts = function()
		local builtin = require('telescope.builtin')

		-- Keymaps for Telescope functions
		vim.keymap.set('n', 'F', builtin.find_files, { desc = 'Telescope find files' })
		vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
		vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
		vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

		-- Return Telescope setup options (if any customization is needed)
		return {
			defaults = {
				mappings = {
					i = {
						-- Example: Map <Esc> to close Telescope in insert mode
						["<Esc>"] = require('telescope.actions').close,
					},
				},
			},
		}
	end,
}
