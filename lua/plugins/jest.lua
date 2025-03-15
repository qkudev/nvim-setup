return {
  "mattkubej/jest.nvim",
  keys = {
    {
      "<leader>jf",
      function()
        require("nvim-jest").test_file()
      end,
      desc = "Jest File",
    },
    {
      "<leader>js",
      function()
        require("nvim-jest").test_single()
      end,
      desc = "Jest Single",
    },
    {
      "<leader>jp",
      function()
        require("nvim-jest").test_project()
      end,
      desc = "Jest Project",
    },
    {
      "<leader>jc",
      function()
        require("nvim-jest").test_coverage()
      end,
      desc = "Jest Coverage",
    },
  },
  dependencies = {
    -- which key integration
    {
      "folke/which-key.nvim",
      optional = true,
      opts = {
        spec = {
          ["<leader>j"] = { name = "+jest" },
        },
      },
    },
  },
}
