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
              -- prettier silently no-ops on gitignored files (e.g. brainess/plans/ is
              -- intentionally gitignored scratch space); bypass that check here since we
              -- still want prose-wrap formatting to run on them.
              return vim.list_extend(
                base,
                { "--prose-wrap", "always", "--print-width", "80", "--ignore-path", "/dev/null" }
              )
            end
            return base
          end,
        },
      },
    },
  },
}
