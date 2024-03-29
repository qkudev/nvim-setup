local has_words_before = function()
  unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

return {
  "hrsh7th/nvim-cmp",
  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")
    require("luasnip/loaders/from_vscode").lazy_load()

    cmp.setup({
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ["<C-l>"] = cmp.mapping.select_prev_item(),
        ["<C-k>"] = cmp.mapping.select_next_item(),
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
        ["<C-e>"] = cmp.mapping.abort(), -- close completion window
        -- ["<CR>"] = cmp.mapping.confirm({ select = false }),

        ["<CR>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            local selectedEntry = cmp.get_selected_entry()
            if selectedEntry then
              cmp.confirm()
            else
              cmp.select_next_item()
              cmp.confirm()
            end

          -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
          -- they way you will only jump inside the snippet region
          else
            fallback()
          end
        end, { "i", "s" }),
        --
        -- ["<S-Tab>"] = cmp.mapping(function(fallback)
        -- 	if cmp.visible() then
        -- 		cmp.select_prev_item()
        -- 	elseif luasnip.jumpable(-1) then
        -- 		luasnip.jump(-1)
        -- 	else
        -- 		fallback()
        -- 	end
        -- end, { "i", "s" }),
      }),
      sources = cmp.config.sources({
        { name = "nvim_lsp" }, -- lsp
        { name = "luasnip" }, -- snippets
        { name = "path" }, -- file system paths
      }),
    })
  end,
}
