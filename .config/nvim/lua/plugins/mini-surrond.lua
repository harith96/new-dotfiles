return {
    "echasnovski/mini.surround",
    version = "*", -- Use the latest stable version
    event = "VeryLazy", -- Load when the editor is idle
    config = function()
      require("mini.surround").setup({
        -- Your custom configurations (optional)
        -- Default config:
        -- mappings = {
        --   add = 'sa', -- Add surrounding
        --   delete = 'sd', -- Delete surrounding
        --   find = 'sf', -- Find surrounding
        --   find_left = 'sF', -- Find surrounding backwards
        --   highlight = 'sh', -- Highlight surrounding
        --   replace = 'sr', -- Replace surrounding
        --   update_n_lines = 'sn', -- Update `n_lines`
        -- },
      })
    end,
  }
