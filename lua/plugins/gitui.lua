local function git_root(start)
  local uv = vim.uv or vim.loop
  local path = start
  if path == nil or path == '' then path = uv.cwd() end
  local dot_git = vim.fs.find('.git', { path = path, upward = true, limit = 1 })[1]
  if not dot_git then return nil end
  return vim.fs.dirname(dot_git)
end

local function open_gitui(start)
  local root = git_root(start)
  if not root then
    vim.notify(
      ('No git repository at or above %s'):format(vim.fn.fnamemodify(start, ':~')),
      vim.log.levels.WARN,
      { title = 'GitUi' }
    )
    return
  end
  Snacks.terminal({ 'gitui' }, { cwd = root })
end

return {
  {
    'mason-org/mason.nvim',
    keys = {
      {
        '<leader>gG',
        function() open_gitui((vim.uv or vim.loop).cwd()) end,
        desc = 'GitUi (cwd)',
      },
      {
        '<leader>gg',
        function() open_gitui(LazyVim.root.get()) end,
        desc = 'GitUi (Root Dir)',
      },
    },
  },
}
