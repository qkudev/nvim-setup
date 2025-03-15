return {
  "folke/trouble.nvim",
  opts = {
    use_diagnostic_signs = true,
    mode = "lsp_references",
    position = "left",
    auto_close = true,
    modes = {
      symbols = { -- Configure symbols mode
        win = {
          type = "split", -- split window
          relative = "win", -- relative to current window
          position = "right", -- right side
          size = 0.3, -- 30% of the window
        },
      },
      fzf = { -- Configure symbols mode
        win = {
          type = "split", -- split window
          relative = "win", -- relative to current window
          position = "right", -- right side
          size = 0.3, -- 30% of the window
        },
      },
      -- @type trouble.Window.opts
      fzf_files = { -- Configure symbols mode
        win = {
          type = "split", -- split window
          relative = "win", -- relative to current window
          position = "right", -- right side
          size = 0.3, -- 30% of the window
        },
      },
    },
    height = 20,
    action_keys = {
      previous = "l",
      next = "k",
    },
    auto_jump = { "lsp_references", "lsp_implementations", "lsp_definitions", "lsp_type_definitions" },
    include_declaration = { "lsp_definitions" },
  },
}
