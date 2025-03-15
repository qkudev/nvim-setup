return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  opts = function(_, opts)
    table.insert(opts.sections.lualine_c, "diff")

    local datetime = {
      function()
        return os.date("%H:%M %d.%m.%Y")
      end,
      icon = "",
    }

    opts.sections.lualine_x = { "lsp_status" }
    opts.sections.lualine_y = { "diagnostics" }
    opts.sections.lualine_z = { datetime }
  end,
}
