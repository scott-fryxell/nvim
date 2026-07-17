-- Inject CSS highlighting into <style lang="stylus"> blocks in Vue SFCs.
-- No tree-sitter-stylus parser exists, so css is the closest approximation.
-- `; extends` preserves the default vue injections and appends this rule.
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
