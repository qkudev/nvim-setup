return {
  "nvim-telescope/telescope.nvim",
  dependencies = { "nvim-telescope/telescope-fzf-native.nvim" },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")
    local open_with_trouble = require("trouble.sources.telescope").open

    telescope.setup({
      defaults = {
        path_display = { "truncate" },
        layout_strategy = "vertical",
        wrap_results = true,
        layout_config = {
          vertical = { width = 0.999, height = 0.999 },
          horizontal = { width = 0.999, height = 0.999 },
        },
        cache_picker = {
          num_pickers = 10,
          limit_entries = 20,
        },
        file_ignore_patterns = {
          -- "node_modules",
          "package%-lock.json",
          "yarn.lock",
        },
        mappings = {
          i = {
            ["<C-l>"] = actions.move_selection_previous,
            ["<C-k>"] = actions.move_selection_next,
            ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
            ["<C-t>"] = open_with_trouble,
          },
        },
        vimgrep_arguments = {
          "rg",
          "--with-filename",
          "--column",
          "--smart-case",
          "--trim",
        },
      },
      pickers = {
        buffers = {
          show_all_buffers = true,
          sort_mru = true,
          mappings = {
            i = {
              ["<c-d>"] = "delete_buffer",
            },
          },
        },
      },
    })

    telescope.load_extension("fzf")
    telescope.load_extension("notify")
  end,
}
