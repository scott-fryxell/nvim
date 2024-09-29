-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
vim.keymap.set("n", "-", "<CMD>Oil<CR>*", { desc = "Open parent directory" })

vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename" })
vim.keymap.set("n", "<Leader>ca", vim.lsp.buf.code_action, { desc = "Code action" })

vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { desc = "Go to implementation" })
vim.keymap.set("n", "gr", require("telescope.builtin").lsp_references, { desc = "Go to references" })

vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover" })

vim.keymap.set("n", "<leader>fb", require("telescope.builtin").buffers, { desc = "Buffers" })
vim.keymap.set("n", "<C-d>", "<Del>", { desc = "Forward delete a letter" })

vim.keymap.set("i", "<C-d>", "<Del>", { desc = "Forward delete a letter" })
vim.keymap.set("i", "kj", "<Esc>", { desc = "Esc" })
vim.keymap.set({"i", "n"}, "hh",function() vim.b.x = not vim.b.x require('cmp').setup.buffer { enabled = not vim.b.x } end, { desc = "Fuck Autocompletion" })

--https://github.com/hrsh7th/nvim-cmp/issues/850
-- ['<C-n>'] = mapping(mapping.select_next_item({ behavior = types.cmp.SelectBehavior.Select }), { 'i', 'c' }),
-- ['<C-p>'] = mapping(mapping.select_prev_item({ behavior = types.cmp.SelectBehavior.Select }), { 'i', 'c' }),

-- Other thing i can do if  I want to disable UI clutter
  -- disable inline hints <leader>uh
  -- LspStop and LspStart



