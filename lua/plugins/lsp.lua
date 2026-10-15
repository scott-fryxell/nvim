return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      diagnostics = {
        update_in_insert = false,
      },
      inlay_hints = {
        exclude = {
          "javascript",
          "javascriptreact",
          "javascript.jsx",
          "typescript",
          "typescriptreact",
          "typescript.tsx",
          "vue",
        },
      },
      servers = {
        bashls = {
          settings = {
            bashIde = {
              shellcheckPath = "",
            },
          },
        },
      },
    },
  },
}