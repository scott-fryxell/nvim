-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- Stylus: treesitter has no fold queries, so fall back to indent folding
-- Stylus is whitespace-significant, so indent-based folds work naturally
vim.api.nvim_create_autocmd("FileType", {
  pattern = "stylus",
  callback = function()
    vim.opt_local.foldmethod = "indent"
    vim.opt_local.foldenable = true
  end,
})
