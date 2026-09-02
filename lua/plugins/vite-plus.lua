-- Vite Plus projects keep formatter options in vite.config.js (`fmt`), so run
-- the project's own `vp fmt` rather than bare prettier, whose defaults undo
-- them (de-indented <script>, semicolons, double quotes).
return {
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = function(_, opts)
      local util = require("conform.util")
      local find_vp = util.find_executable({ "node_modules/.bin/vp" }, "")

      opts.formatters = opts.formatters or {}
      opts.formatters.vp_fmt = {
        command = find_vp,
        args = { "fmt", "--stdin-filepath", "$FILENAME" },
        cwd = util.root_file({ "vite.config.js", "vite.config.ts" }),
        require_cwd = true,
        condition = function(self, ctx)
          return find_vp(self, ctx) ~= ""
        end,
      }

      opts.formatters_by_ft = opts.formatters_by_ft or {}
      for _, ft in ipairs({
        "vue",
        "javascript",
        "typescript",
        "javascriptreact",
        "typescriptreact",
        "json",
        "jsonc",
        "css",
        "scss",
        "less",
        "yaml",
      }) do
        local list = opts.formatters_by_ft[ft] or {}
        table.insert(list, 1, "vp_fmt")
        list.stop_after_first = true
        opts.formatters_by_ft[ft] = list
      end

      return opts
    end,
  },
}
