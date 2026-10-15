local function drop(list, name)
  return vim.tbl_filter(function(item)
    return item ~= name
  end, list or {})
end

return {
  {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = function(_, opts)
      opts.linters_by_ft = opts.linters_by_ft or {}
      opts.linters_by_ft.markdown = {}
      opts.linters_by_ft["markdown.mdx"] = {}
    end,
  },
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = function(_, opts)
      local by_ft = opts.formatters_by_ft or {}
      for _, ft in ipairs({ "markdown", "markdown.mdx" }) do
        by_ft[ft] = drop(by_ft[ft], "markdownlint-cli2")
      end
      opts.formatters_by_ft = by_ft
    end,
  },
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = drop(opts.ensure_installed, "markdownlint-cli2")
    end,
  },
}
