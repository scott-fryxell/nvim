vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename" })
vim.keymap.set("n", "<Leader>ca", vim.lsp.buf.code_action, { desc = "Code action" })

vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { desc = "Go to implementation" })
vim.keymap.set("n", "gr", function() Snacks.picker.lsp_references() end, { desc = "Go to references", nowait = true })

vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover" })

vim.keymap.set("n", "<leader>fb", function() Snacks.picker.buffers() end, { desc = "Buffers" })
vim.keymap.set("n", "<leader>fv", vim.diagnostic.open_float, { desc = "Open float for lsp messages" })
vim.keymap.set("i", "<C-d>", "<Del>", { desc = "Forward delete a letter" })




vim.keymap.set("n", "<space><space>x", "<cmd>source %<CR>")
vim.keymap.set("n", "<space>x", ":.lua<CR>")
vim.keymap.set("v", "<space>x", ":lua<CR>")
local emacs_insert = {
  ["<C-a>"] = { "<C-o>0", "Beginning of line" },
  ["<C-e>"] = { "<C-o>$", "End of line" },
  ["<C-f>"] = { "<Right>", "Forward character" },
  ["<C-b>"] = { "<Left>", "Backward character" },
  ["<C-d>"] = { "<Del>", "Forward delete" },
  ["<C-h>"] = { "<BS>", "Backspace" },
  ["<C-k>"] = { "<C-o>D", "Delete to end of line" },
  ["<C-u>"] = { "<C-o>d0", "Delete to beginning of line" },
  ["<C-w>"] = { "<C-o>db", "Delete word backward" },
}

for key, map in pairs(emacs_insert) do
  vim.keymap.set("i", key, map[1], { desc = map[2] })
end

local emacs_cmdline = {
  ["<C-a>"] = "<Home>",
  ["<C-e>"] = "<End>",
  ["<C-f>"] = "<Right>",
  ["<C-b>"] = "<Left>",
  ["<C-d>"] = "<Del>",
  ["<C-h>"] = "<BS>",
}

for key, rhs in pairs(emacs_cmdline) do
  vim.keymap.set("c", key, rhs, { desc = "Emacs line edit" })
end
