-- return {
--   "hrsh7th/nvim-cmp",
--   dependencies = { "hrsh7th/cmp-emoji" },
--   opts = function(_, opts)
--     table.insert(opts.sources, { name = "emoji" })
--     local cmp = require("cmp")
--     cmp.setup({
--       enabled = false,
--       preselect = cmp.PreselectMode.None,
--       sources = {
--         { name = 'buffer' },
--         { name = 'nvim_lsp' },
--         { name = 'luasnip' },
--         { name = 'path' },
--         { name = 'emoji' },
--       }
--     })
--   end,
-- }


return {
  {
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      opts.completion.autocomplete = false
      opts.mapping["<CR>"] = nil
      opts.window = {
        completion = {
          border = {
            { "󱐋", "WarningMsg" },
            { "─", "Comment" },
            { "╮", "Comment" },
            { "│", "Comment" },
            { "╯", "Comment" },
            { "─", "Comment" },
            { "╰", "Comment" },
            { "│", "Comment" },
          },
          scrollbar = false,
          winblend = 0,
        },
        documentation = {
          border = {
            { "󰙎", "DiagnosticHint" },
            { "─", "Comment" },
            { "╮", "Comment" },
            { "│", "Comment" },
            { "╯", "Comment" },
            { "─", "Comment" },
            { "╰", "Comment" },
            { "│", "Comment" },
          },
          scrollbar = false,
          winblend = 0,
        },
      }
    end,
  },
}
