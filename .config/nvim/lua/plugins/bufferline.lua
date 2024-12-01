return {
	"akinsho/bufferline.nvim",
	version = "*",                                 -- Use the latest stable version
	dependencies = { "nvim-tree/nvim-web-devicons" }, -- Optional, for file icons
	event = "VeryLazy",                            -- Load lazily for better startup performance
	opts = {
		-- Customize bufferline options
		options = {
			numbers = "none",          -- "none", "ordinal", "buffer_id", "both"
			close_command = "bdelete! %d", -- Command to close a buffer
			right_mouse_command = "bdelete! %d", -- Right-click close
			left_mouse_command = "buffer %d", -- Left-click to select buffer
			middle_mouse_command = nil, -- Middle-click disabled
			diagnostics = "nvim_lsp",  -- Show diagnostics from LSP
			separator_style = "slant", -- Options: "slant", "thick", "thin", etc.
			always_show_bufferline = true, -- Always display the bufferline
		}
	}
}
