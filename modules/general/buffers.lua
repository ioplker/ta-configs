local bind = require('shortcuts').bind


-- Tabs changing
LOCKED_BUFFER_MARKER = '%'
UNSAVED_BUFFER_MARKER = '*'

local function next_buffer() view.goto_buffer(_G.view, -1) end
local function prev_buffer() view.goto_buffer(_G.view, 1) end

local function move_buffer_left()
  local cur_view_index = _BUFFERS[_G.buffer]

  if cur_view_index-1 >= 1 then
    _G.move_buffer(cur_view_index, cur_view_index-1)

    events.emit('BUFFER_MOVED', _G.buffer)
    events.emit('BUFFER_MOVED', _BUFFERS[cur_view_index])
  end
end

local function move_buffer_right()
  local cur_view_index = _BUFFERS[_G.buffer]

  if _BUFFERS[cur_view_index+1] ~= nil then
    _G.move_buffer(cur_view_index, cur_view_index+1)

    events.emit('BUFFER_MOVED', _G.buffer)
    events.emit('BUFFER_MOVED', _BUFFERS[cur_view_index])
  end
end

local function go_to_buffer(number)
  if _G._BUFFERS[number] ~= nil then
    view.goto_buffer(view, _G._BUFFERS[number])
  end
end

local function update_buffer_index_label(buffer)
  local index = _G._BUFFERS[buffer]
  local tab_title = 'Untitled'

  -- NOTE: `buffer._type` not nil for system buffers like `[Message Buffer]` etc
  if buffer._type ~= nil then
    tab_title = buffer._type
  elseif buffer.filename ~= nil then
    tab_title = buffer.filename and buffer.filename:match("([^/]+)$")
  end

  if buffer.modify then
    tab_title = tab_title .. UNSAVED_BUFFER_MARKER
  end

  if buffer.read_only and buffer._type == nil then
    buffer.tab_label = '[' .. index .. '] [' .. LOCKED_BUFFER_MARKER .. '] ' .. tab_title
  else
    buffer.tab_label = '[' .. index .. '] ' .. tab_title
  end
end

local function toggle_buffer_readonly()
  if buffer._type == nil and buffer.filename ~= nil then
    buffer.read_only = not buffer.read_only
  end

  update_buffer_index_label(buffer)
end


bind('ctrl+pgup', next_buffer)
bind('ctrl+pgdn', prev_buffer)
bind('ctrl+shift+pgup', move_buffer_left)
bind('ctrl+shift+pgdn', move_buffer_right)
bind('alt+1', function() go_to_buffer(1) end)
bind('alt+2', function() go_to_buffer(2) end)
bind('alt+3', function() go_to_buffer(3) end)
bind('alt+4', function() go_to_buffer(4) end)
bind('alt+5', function() go_to_buffer(5) end)
bind('alt+6', function() go_to_buffer(6) end)
bind('alt+7', function() go_to_buffer(7) end)
bind('alt+8', function() go_to_buffer(8) end)
bind('alt+9', function() go_to_buffer(9) end)
bind('ctrl+%', toggle_buffer_readonly)

events.connect('BUFFER_MOVED', update_buffer_index_label)
events.connect(events.UPDATE_UI, function() update_buffer_index_label(buffer) end)

-- Save buffer on switching away from it
local function save_buffer_with_file()
  if buffer.modify and buffer.filename ~= nil then
    buffer.save(buffer)
    update_buffer_index_label(buffer)
  end
end

events.connect(events.BUFFER_BEFORE_SWITCH, save_buffer_with_file)
events.connect(events.VIEW_BEFORE_SWITCH, save_buffer_with_file)
events.connect(events.FILE_AFTER_SAVE, save_buffer_with_file)

-- NOTE: `events.UNFOCUS` doesn't work in terminal TA
--[[
Also it is triggered by wm closing, so exiting saves all unsaved buffers
  (but still prompts for buffers without files)
]]
events.connect(events.UNFOCUS, save_buffer_with_file)


-- Reopen just closed buffer
local OPENED_BUFFERS = {}    -- order of opening indexed by filenames
local CLOSED_BUFFERS = {}    -- order of closing indexed by filenames

local function remove_from_dict(dict, index)
  local new_dict = {}
  for k, v in ipairs(dict) do
    if k < index then
      new_dict[k] = dict[k]
      new_dict[dict[k]] = k
    else
      if k > index then
        new_dict[k-1] = dict[k]
        new_dict[dict[k]] = k-1
      end
    end
  end

  return new_dict
end

local function record_all_opened_filenames()
  for k, v in pairs(_G._BUFFERS) do
    if type(v) == 'ta_buffer' and v.filename then
      record_opened_filename(v.filename)
    end
  end
end

local function record_opened_filename(filename)
  if not filename then
    filename = buffer.filename
  end

  local new_opened_index = #OPENED_BUFFERS + 1
  OPENED_BUFFERS[filename] = new_opened_index
  OPENED_BUFFERS[new_opened_index] = filename

  -- remove last ordered buffer from closed if we reopened it
  if CLOSED_BUFFERS[filename] then
    local last_closed_index = #CLOSED_BUFFERS
    CLOSED_BUFFERS[filename] = nil
    CLOSED_BUFFERS[last_closed_index] = nil
  end
end

local function record_closed_filename(filename)
  local opened_index = OPENED_BUFFERS[filename]
  OPENED_BUFFERS = remove_from_dict(OPENED_BUFFERS, opened_index)

  local new_closed_index = #CLOSED_BUFFERS + 1
  CLOSED_BUFFERS[filename] = new_closed_index
  CLOSED_BUFFERS[new_closed_index] = filename
end

local function handle_closed_buffer()
  -- get current opened buffers (without just closed buffer)
  local current_buffers = {}
  for k, v in ipairs(_G._BUFFERS) do
    if v.filename then
      current_buffers[v.filename] = v.filename
    end
  end

  -- move missing filename from opened to closed
  local found_filename = ''
  for k, v in ipairs(OPENED_BUFFERS) do
    if not current_buffers[v] then
      found_filename = v
      break
    end
  end
  if found_filename ~= '' then
    record_closed_filename(found_filename)
  end
end

local function reopen_closed_file()
  if #CLOSED_BUFFERS < 1 then return true end

  local last_closed_index = #CLOSED_BUFFERS
  io.open_file(CLOSED_BUFFERS[last_closed_index])

  record_opened_filename(CLOSED_BUFFERS[last_closed_index])
end

events.connect(events.INITIALIZED, record_all_opened_filenames)
events.connect(events.FILE_OPENED, record_opened_filename)
events.connect(events.BUFFER_DELETED, handle_closed_buffer)
bind('ctrl+T', reopen_closed_file)
