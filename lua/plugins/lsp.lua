return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      diagnostics = {
        update_in_insert = false,
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