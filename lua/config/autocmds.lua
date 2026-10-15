
local group = vim.api.nvim_create_augroup("brayness_buffers", { clear = true })

local state_file = vim.fn.stdpath("state") .. "/open-buffers.json"

local function is_file(name)
  return name:sub(1, 1) == "/"
end

local function oil_dir(name)
  if name:sub(1, 6) == "oil://" then
    return name:sub(7)
  end
end

local function collect_buffers()
  local buffers = {}
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_valid(buf) and vim.api.nvim_buf_get_option(buf, "buflisted") then
      local name = vim.api.nvim_buf_get_name(buf)
      if is_file(name) then
        table.insert(buffers, name)
      end
    end
  end
  table.sort(buffers)
  return buffers
end

local function oil_highlighted_entry(buf, win)
  local line = vim.api.nvim_win_get_cursor(win)[1]
  local text = vim.api.nvim_buf_get_lines(buf, line - 1, line, false)[1]
  if text and text ~= "" then
    return vim.trim(text)
  end
end

local function collect_oil()
  local entries = {}
  local win_for_buf = {}
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    win_for_buf[vim.api.nvim_win_get_buf(win)] = win
  end
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_valid(buf) and vim.api.nvim_buf_is_loaded(buf) then
      local dir = oil_dir(vim.api.nvim_buf_get_name(buf))
      if dir then
        local win = win_for_buf[buf]
        table.insert(entries, {
          dir = dir,
          highlighted = win and oil_highlighted_entry(buf, win) or nil,
        })
      end
    end
  end
  table.sort(entries, function(a, b)
    return a.dir < b.dir
  end)
  return entries
end

local scratch_max_bytes = 200 * 1024
local scratch_max_bytes_per_buffer = 64 * 1024

local function collect_scratch()
  local entries = {}
  local total = 0
  local text_limit = scratch_max_bytes_per_buffer
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_valid(buf) and vim.api.nvim_buf_is_loaded(buf) then
      local name = vim.api.nvim_buf_get_name(buf)
      if vim.bo[buf].buftype == "" and (not is_file(name) or vim.bo[buf].modified) then
        local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
        if #lines == 1 and lines[1] == "" then lines = {} end
        local text = table.concat(lines, "\n")
        local capped = #text > text_limit or total + #text > scratch_max_bytes
        if not capped then total = total + #text end
        table.insert(entries, {
          bufnr = buf,
          name = name ~= "" and name or nil,
          filetype = vim.bo[buf].filetype ~= "" and vim.bo[buf].filetype or nil,
          lines = #lines,
          capped = capped or nil,
          text = capped and nil or text,
        })
      end
    end
  end
  return entries
end

local function current_view()
  local win = vim.api.nvim_get_current_win()
  local buf = vim.api.nvim_win_get_buf(win)
  local name = vim.api.nvim_buf_get_name(buf)
  local dir = oil_dir(name)
  if not (is_file(name) or dir) then
    return nil
  end
  local line, col = unpack(vim.api.nvim_win_get_cursor(win))
  local top, bot = vim.fn.line("w0"), vim.fn.line("w$")
  local from, to = math.max(1, line - 3), math.min(vim.api.nvim_buf_line_count(buf), line + 3)
  local context = vim.api.nvim_buf_get_lines(buf, from - 1, to, false)
  return {
    file = is_file(name) and name or dir,
    line = line,
    col = col,
    visible = { from_top = top, to_bottom = bot },
    context = context,
  }
end

local function write_state()
  local current = vim.api.nvim_buf_get_name(0)
  local data = vim.json.encode({
    current = is_file(current) and current or oil_dir(current) or nil,
    buffers = collect_buffers(),
    scratch = collect_scratch(),
    oil = collect_oil(),
    view = current_view(),
    updated = os.date("%Y-%m-%dT%H:%M:%S"),
  })
  local fd = io.open(state_file, "w")
  if fd then
    fd:write(data)
    fd:close()
  end
end

vim.api.nvim_create_autocmd(
  { "VimEnter", "BufAdd", "BufEnter", "BufDelete", "BufWipeout", "VimLeavePre", "FocusGained", "TextChanged", "InsertLeave" },
  { group = group, callback = write_state }
)

local timer = vim.uv.new_timer()
timer:start(
  5000,
  5000,
  vim.schedule_wrap(function()
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
      if vim.api.nvim_buf_is_valid(buf) and vim.bo[buf].modified then
        write_state()
        return
      end
    end
  end)
)

vim.api.nvim_create_autocmd("FileType", {
  pattern = "stylus",
  callback = function()
    vim.opt_local.foldmethod = "indent"
    vim.opt_local.foldenable = true
  end,
})

local function continue_list()
  local line = vim.api.nvim_get_current_line()
  local indent, marker, rest = line:match("^(%s*)([-*+])%s+(.*)$")
  if not marker then
    local number, punct
    indent, number, punct, rest = line:match("^(%s*)(%d+)([.)])%s+(.*)$")
    if number then marker = tostring(tonumber(number) + 1) .. punct end
  end
  if not marker then return "\r" end
  if rest == "" then
    vim.api.nvim_set_current_line("")
    return "\r"
  end
  return "\r" .. indent .. marker .. " "
end

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown", "markdown.mdx" },
  callback = function(ev)
    vim.keymap.set("i", "<CR>", continue_list, { buffer = ev.buf, expr = true })
  end,
})
