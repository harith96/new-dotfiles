return {
	"rmagatti/auto-session",
	version = "*",   -- Use the latest stable version
	event = "VimEnter", -- Load when entering Neovim
	opts = function()
		vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

		return {
			log_level = "info",                                    -- Set logging level (e.g., "info", "warn", "error")
			auto_session_enabled = true,                           -- Enable auto-session
			auto_session_root_dir = vim.fn.stdpath("data") .. "/sessions/", -- Directory to store session files
			auto_restore_enabled = true,                           -- Automatically restore the last session on startup
			auto_save_enabled = true,                              -- Automatically save session when exiting Neovim
			auto_session_suppress_dirs = { "~/" },                 -- Ignore specific directories
		}
	end,
}

