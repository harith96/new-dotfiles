return {
    'mbbill/undotree',
    config = function()

        -- Optional: Set a keybinding to toggle Undotree
        vim.keymap.set('n', '<leader>u', ':UndotreeToggle<CR>', { noremap = true, silent = true, desc = "Toggle Undotree" })

		if vim.fn.has("persistent_undo") == 1 then
    		local target_path = vim.fn.expand("~/undodir")

    		-- Create the directory and any parent directories if it doesn't exist
			if vim.fn.isdirectory(target_path) == 0 then
				vim.fn.mkdir(target_path, "p", 0700)
			end

			vim.opt.undodir = target_path
			vim.opt.undofile = true
		end
    end,
}
