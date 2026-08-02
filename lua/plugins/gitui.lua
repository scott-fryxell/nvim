-- The util.gitui extra hands gitui whatever LazyVim.root.get() returns, which
-- falls back to the cwd when nothing above the buffer holds a .git. gitui then
-- exits immediately with "invalid repo path" inside a Snacks float, so the
-- float just flashes and disappears with no visible reason. Resolve an actual
-- git root before launching, and say plainly when there isn't one.
local function git_root(start)
  local uv = vim.uv or vim.loop
  local path = start
  if path == nil or path == '' then path = uv.cwd() end
  -- .git is a file, not a directory, inside worktrees and submodules.
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
