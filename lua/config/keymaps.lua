-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set("n", "-", "<CMD>Oil<CR>*", { desc = "Open parent directory" })

vim.keymap.set("i", "<C-d>", "<Del>", { desc = "Forward delete a letter" })
vim.keymap.set("n", "<C-d>", "<Del>", { desc = "Forward delete a letter" })

vim.keymap.set("i", "jj", "<Esc>", { desc = "Esc" })
