local group = vim.api.nvim_create_augroup("realness_background", { clear = true })

vim.api.nvim_create_autocmd("OptionSet", {
  group = group,
  pattern = "background",
  nested = true,
  callback = function()
    if vim.g.colors_name == "realness" then vim.cmd.colorscheme("realness") end
  end,
})

vim.api.nvim_create_autocmd("FocusGained", {
  group = group,
  callback = function()
    if #vim.api.nvim_list_uis() > 0 then vim.api.nvim_ui_send("\027]11;?\007") end
  end,
})

vim.api.nvim_create_autocmd("ColorScheme", {
  group = group,
  callback = function()
    local hl = function(name) return vim.api.nvim_get_hl(0, { name = name, link = false }) end
    local normal, comment, selected = hl("Normal"), hl("Comment"), hl("TabLineSel")
    vim.api.nvim_set_hl(0, "BufferLineTab", { fg = comment.fg, bg = normal.bg })
    vim.api.nvim_set_hl(0, "BufferLineTabSelected", { fg = normal.bg, bg = selected.fg, bold = true })
  end,
})

return {
  {
    "akinsho/bufferline.nvim",
    opts = {
      highlights = function()
        local normal = vim.api.nvim_get_hl(0, { name = "Normal", link = false })
        local comment = vim.api.nvim_get_hl(0, { name = "Comment", link = false })
        local selected = vim.api.nvim_get_hl(0, { name = "TabLineSel", link = false })
        return {
          tab = { fg = comment.fg, bg = normal.bg, default = false },
          tab_selected = { fg = normal.bg, bg = selected.fg, bold = true, default = false },
        }
      end,
    },
  },
  { "olimorris/onedarkpro.nvim", priority = 1000 },
  { "nvim-mini/mini.base16", version = false, lazy = false, priority = 1000 },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "realness",
    },
  },
}
