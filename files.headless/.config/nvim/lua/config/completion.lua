local cmp = require("cmp")
local luasnip = require("luasnip")

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end
  },
  mapping = {
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-e>"] = cmp.mapping.close(),
    ["<C-y>"] = cmp.mapping.confirm(
      {
        select = true,
        behavior = cmp.ConfirmBehavior.Insert
      }
    )
  },
  sources = {
    {name = "buffer"},
    {name = "nvim_lsp"},
    {name = "nvim_lua"},
    {name = "path"},
    {name = "luasnip"}
  }
}
