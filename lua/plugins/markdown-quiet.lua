return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        marksman = { enabled = false },
      },
    },
  },
  {
    "saghen/blink.cmp",
    opts = function(_, opts)
      opts.enabled = function()
        return not vim.tbl_contains({ "markdown", "markdown.mdx" }, vim.bo.filetype)
      end
    end,
  },
}
