-- Extra maps <leader>fg to git_files, which errors outside a git root.
return {
  {
    "folke/snacks.nvim",
    keys = {
      { "<leader>fg", function() Snacks.picker.grep() end, desc = "Grep (Root Dir)" },
    },
  },
}
