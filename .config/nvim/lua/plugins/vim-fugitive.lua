return {
    'tpope/vim-fugitive',
    config = function()
        -- Bind the G key to the Gedit command (in normal mode)
        vim.keymap.set('n', 'G', ':Gedit :<CR>6j', { noremap = true, silent = true, desc = "Open git status for the whole project" })
    end,
}
