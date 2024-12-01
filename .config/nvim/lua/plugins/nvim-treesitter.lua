return {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate', -- Run `:TSUpdate` after installation
    config = function()
        require('nvim-treesitter.configs').setup {
            -- Enable modules or language features here
            ensure_installed = { "lua", "javascript", "typescript", "python" }, -- List of languages to install
            highlight = {
                enable = true, -- Enable syntax highlighting
                additional_vim_regex_highlighting = false,
            },
indent = { enable = true },  
sync_install = false,
        }
    end,
}
