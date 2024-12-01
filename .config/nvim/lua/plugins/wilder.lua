return {
  "gelguy/wilder.nvim",
  event = "VimEnter", -- or use any other appropriate event for lazy loading
  opts = {
    modes = { ":", "/", "?" },  -- Enable wilder in command-line modes
    next_key = "<Tab>",         -- Key to move to next completion
    previous_key = "<S-Tab>",   -- Key to move to previous completion
  },
}
