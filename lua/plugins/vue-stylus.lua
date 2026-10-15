return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.treesitter.query.set(
        "vue",
        "injections",
        [[
; extends

((style_element
  (start_tag
    (attribute
      (attribute_name) @_lang
      (quoted_attribute_value
        (attribute_value) @_stylus)))
  (raw_text) @injection.content)
  (#eq? @_lang "lang")
  (#eq? @_stylus "stylus")
  (#set! injection.language "css"))
]]
      )
      return opts
    end,
  },
}
