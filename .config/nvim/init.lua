-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out,                            "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end

-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- optionally enable 24-bit colour
vim.opt.termguicolors = true

-- Add Lazy to RTP
vim.opt.rtp:prepend(lazypath)

-- Line numbers
vim.opt.number = true

-- Encoding
vim.opt.encoding = "utf-8"

-- Indentation
-- vim.opt.autoindent = true
-- vim.opt.smartindent = true
-- vim.opt.tabstop = 4
-- vim.opt.shiftwidth = 4

-- Mouse and UI settings
vim.opt.mouse = "a"
vim.opt.background = "dark"

-- Folding
vim.opt.foldmethod = "syntax"
vim.opt.foldlevelstart = 99

-- Splits
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Miscellaneous
vim.opt.hidden = true
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.termguicolors = true
vim.opt.clipboard = "unnamedplus"


-- Key mappings
-- Set leader key
vim.g.mapleader = "," -- Global leader
vim.keymap.set("", "<space><Enter>", "i<CR><Esc>", { silent = true, nowait = true })

-- Save and quit mappings
vim.keymap.set("n", "<C-s>", ":wa<CR>", { noremap = true })
vim.keymap.set("i", "<C-s>", "<Esc>:wa<CR>i", { noremap = true })
vim.keymap.set("n", "<C-q>", ":wqa<CR>", { noremap = true })

-- Buffer navigation
vim.keymap.set("n", "bn", ":bn<CR>", { noremap = true })
vim.keymap.set("n", "bp", ":bp<CR>", { noremap = true })
vim.keymap.set("n", "bd", ":bd<CR>", { noremap = true })
vim.keymap.set("n", "<C-b>", ":Buffers<CR>", { noremap = true })

-- Yank and paste from system clipboard
vim.keymap.set("v", "<C-y>", '"+y', { silent = true, nowait = true })
vim.keymap.set("n", "<C-p>", '"+p', { silent = true, nowait = true })
vim.keymap.set("v", "<C-p>", '"+p', { silent = true, nowait = true })
vim.keymap.set("i", "<C-p>", '<Esc>"+pi', { silent = true, nowait = true })

-- Copy file path to clipboard
vim.keymap.set("n", "<C-l>", ':let @+ = expand("%")<CR>', { silent = true, nowait = true })

-- Split window
vim.keymap.set("n", "vs", ":vsplit<CR>", { silent = true, nowait = true })

-- Quit shortcuts
-- vim.keymap.set("n", "Q", "q", { silent = true, nowait = true })
-- vim.keymap.set("n", "q", ":q<CR>", { silent = true, nowait = true })

-- Navigate visual lines instead of physical lines
vim.keymap.set("n", "j", "gj", { noremap = true })
vim.keymap.set("n", "k", "gk", { noremap = true })
vim.keymap.set("n", "gj", "j", { noremap = true })
vim.keymap.set("n", "gk", "k", { noremap = true })

-- Search within the current visual block
vim.keymap.set("n", "ws", "/\\v<><Left>", { noremap = true })
vim.keymap.set("v", "s", "/\\%V", { noremap = true })

-- Clear search highlights
vim.keymap.set("n", "sl", ":noh<CR>", { silent = true, nowait = true })
vim.keymap.set("v", "sl", ":noh<CR>", { silent = true, nowait = true })

-- Source .vimrc file
vim.keymap.set("n", "so", ":so ~/.vimrc<CR>", { noremap = true })

-- Move to end of line, delete, then move to the next line
vim.keymap.set("n", "el", "<End>x<Down>", { noremap = true })

-- Delete without yanking
vim.keymap.set("v", "x", '"_d', { nowait = true })

-- Replace selected text with the default register without yanking it
vim.keymap.set("v", "<leader>p", '"_dP', { noremap = true })

-- Move lines up and down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Replace word under cursor
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Move between quickfix and location lists
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- Custom command: Close all buffers except the current one
vim.api.nvim_create_user_command("BufCurOnly", function()
	vim.cmd([[%bdelete|edit#|bdelete#]])
end, {})


local plugins = {
	spec = {
		{ import = "plugins" }
	},
	-- Configure any other settings here. See the documentation for more details.
	-- colorscheme that will be used when installing plugins.
	install = { colorscheme = { "habamax" } },
	-- automatically check for plugin updates
	checker = { enabled = true },
}

local opts = {}

-- Setup lazy.nvim
require("lazy").setup(plugins, opts)
