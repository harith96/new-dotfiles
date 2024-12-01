return {
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		branch = "canary",
		dependencies = {
			{ "zbirenbaum/copilot.lua" }, -- or zbirenbaum/copilot.lua
			{ "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
		},
		build = "make tiktoken", -- Only on MacOS or Linux
		opts = function()
			vim.keymap.set("n", "<leader>ccq",
				function()
					local input = vim.fn.input("Quick Chat: ")
					if input ~= "" then
						require("CopilotChat").ask(input, { selection = require("CopilotChat.select").buffer })
					end
				end
				, { silent = true })

			vim.keymap.set({ "n", "v" }, "<leader>ccp",
				function()
					local actions = require("CopilotChat.actions")
					require("CopilotChat.integrations.telescope").pick(actions.prompt_actions())
				end, { silent = true })

			vim.keymap.set({ "n", "v" }, "<leader>cco", ':CopilotChatToggle<CR>', { silent = true })

			return {}
		end,
		-- See Commands section for default commands if you want to lazy load on them
	},
}
