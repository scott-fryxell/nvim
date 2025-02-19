-- Option are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.opt.scrolloff = 16

-- https://www.jackfranklin.co.uk/blog/code-folding-in-vim-neovim/
-- vim.opt.foldcolumn = "1"
vim.opt.foldlevel = 99
-- vim.opt.foldlevelstart = 1
vim.opt.foldnestmax = 5
vim.opt.foldenable = true
vim.opt.foldmethod = "indent"
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
-- vim.opt.foldtext = ""
vim.g.lazyvim_prettier_needs_config = true

-- https://www.cs.swarthmore.edu/oldhelp/vim/indenting.html
vim.opt.autoindent = true   -- turns it on
vim.opt.smartindent = true  -- does the right thing (mostly) in programs

vim.opt.shiftwidth = 2
vim.opt.clipboard = "unnamedplus"
