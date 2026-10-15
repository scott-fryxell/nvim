
vim.opt.scrolloff = 16

vim.opt.foldlevel = 0
vim.opt.foldlevelstart = 0
vim.opt.foldnestmax = 5
vim.opt.foldenable = true
vim.opt.foldmethod = "indent"
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"

vim.opt.autoindent = true
vim.opt.smartindent = true

vim.opt.shiftwidth = 2
vim.opt.clipboard = "unnamedplus"

vim.opt.swapfile = false

vim.treesitter.language.register("bash", "zsh")
