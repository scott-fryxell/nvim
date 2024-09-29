return {
  "hrsh7th/nvim-cmp",
  dependencies = { "hrsh7th/cmp-emoji" },
  opts = function(_, opts)
    table.insert(opts.sources, { name = "emoji" })
    local cmp = require("cmp")
    cmp.setup({
      enabled = false,
      preselect = cmp.PreselectMode.None,
      sources = {
        { name = 'buffer' },
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'path' },
        { name = 'emoji' },
      }
    })
  end,
}
