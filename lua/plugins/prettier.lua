return {
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters = {
        prettier = {
          args = function(self, ctx)
            local base = require("conform.formatters.prettier").args(self, ctx)
              or { "--stdin-filepath", "$FILENAME" }
            if vim.tbl_contains({ "markdown", "markdown.mdx" }, vim.bo[ctx.buf].filetype) then
              return vim.list_extend(base, { "--prose-wrap", "always", "--print-width", "80" })
            end
            return base
          end,
        },
      },
    },
  },
}
