local M = {
  locked_marker = '%',
  unsaved_marker = '*',
}


--[[----------------------------------------------------------------------------
Moving buffers
------------------------------------------------------------------------------]]
function M.move_buffer_left()
  local cur_view_index = _BUFFERS[_G.buffer]

  if cur_view_index-1 >= 1 then
    _G.move_buffer(cur_view_index, cur_view_index-1)

    events.emit('BUFFER_MOVED', _G.buffer)
    events.emit('BUFFER_MOVED', _BUFFERS[cur_view_index])
  end
end

function M.move_buffer_right()
  local cur_view_index = _BUFFERS[_G.buffer]

  if _BUFFERS[cur_view_index+1] ~= nil then
    _G.move_buffer(cur_view_index, cur_view_index+1)

    events.emit('BUFFER_MOVED', _G.buffer)
    events.emit('BUFFER_MOVED', _BUFFERS[cur_view_index])
  end
end

local function _update_buffer_index_label(buffer)
  local index = _G._BUFFERS[buffer]
  local tab_title = 'Untitled'

  -- NOTE: `buffer._type` is not nil for system buffers like `[Message Buffer]` etc
  if buffer._type ~= nil then
    tab_title = buffer._type
  elseif buffer.filename ~= nil then
    tab_title = buffer.filename and buffer.filename:match("([^/]+)$")
  end

  if buffer.modify then
    tab_title = tab_title .. M.unsaved_marker
  end

  if buffer.read_only and buffer._type == nil then
    buffer.tab_label = '[' .. index .. '] [' .. M.locked_marker .. '] ' .. tab_title
  else
    buffer.tab_label = '[' .. index .. '] ' .. tab_title
  end
end

local function _update_all_labels()
  local index = 1

  while _G._BUFFERS[index] do
    _update_buffer_index_label(_G._BUFFERS[index])
    index = index + 1
  end
end

events.connect('BUFFER_MOVED', _update_buffer_index_label)
events.connect(events.FILE_AFTER_SAVE, function() _update_buffer_index_label(buffer) end)
events.connect(events.UPDATE_UI, function() _update_buffer_index_label(buffer) end)
events.connect(events.BUFFER_DELETED, _update_all_labels)


--[[----------------------------------------------------------------------------
Read-only mode
------------------------------------------------------------------------------]]
-- NOTE: Saves buffer on enabling read-only mode
function M.toggle_buffer_readonly()
  if buffer._type == nil and buffer.filename ~= nil then
    if not buffer.read_only then buffer.save() end
    buffer.read_only = not buffer.read_only
  end

  _update_buffer_index_label(buffer)
end


--[[----------------------------------------------------------------------------
Save buffers on switching
------------------------------------------------------------------------------]]
local function _save_buffer_with_file()
  if buffer.modify and buffer.filename ~= nil then
    buffer.save(buffer)
    _update_buffer_index_label(buffer)
  end
end

events.connect(events.BUFFER_BEFORE_SWITCH, _save_buffer_with_file)
events.connect(events.VIEW_BEFORE_SWITCH, _save_buffer_with_file)
events.connect(events.FILE_AFTER_SAVE, _save_buffer_with_file)

-- NOTE: `events.UNFOCUS` doesn't work in terminal TA
--[[ Also it is triggered by wm closing, so exiting saves all unsaved buffers
(but still prompts for buffers without files)]]
events.connect(events.UNFOCUS, _save_buffer_with_file)


--[[----------------------------------------------------------------------------
Reopen closed buffers
------------------------------------------------------------------------------]]
local _OPENED_BUFFERS = {}    -- order of opening indexed by filenames
local _CLOSED_BUFFERS = {}    -- order of closing indexed by filenames

local function _remove_from_dict(dict, index)
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

local function _record_all_opened_filenames()
  for k, v in pairs(_G._BUFFERS) do
    if type(v) == 'ta_buffer' and v.filename then
      _record_opened_filename(v.filename)
    end
  end
end

local function _record_opened_filename(filename)
  if not filename then
    filename = buffer.filename
  end

  local new_opened_index = #_OPENED_BUFFERS + 1
  _OPENED_BUFFERS[filename] = new_opened_index
  _OPENED_BUFFERS[new_opened_index] = filename

  -- remove last ordered buffer from closed if we reopened it
  if _CLOSED_BUFFERS[filename] then
    local last_closed_index = #_CLOSED_BUFFERS
    _CLOSED_BUFFERS[filename] = nil
    _CLOSED_BUFFERS[last_closed_index] = nil
  end
end

local function _record_closed_filename(filename)
  local opened_index = _OPENED_BUFFERS[filename]
  _OPENED_BUFFERS = _remove_from_dict(_OPENED_BUFFERS, opened_index)

  local new_closed_index = #_CLOSED_BUFFERS + 1
  _CLOSED_BUFFERS[filename] = new_closed_index
  _CLOSED_BUFFERS[new_closed_index] = filename
end

local function _handle_closed_buffer()
  -- get current opened buffers (without just closed buffer)
  local current_buffers = {}
  for k, v in ipairs(_G._BUFFERS) do
    if v.filename then
      current_buffers[v.filename] = v.filename
    end
  end

  -- move missing filename from opened to closed
  local found_filename = ''
  for k, v in ipairs(_OPENED_BUFFERS) do
    if not current_buffers[v] then
      found_filename = v
      break
    end
  end
  if found_filename ~= '' then
    _record_closed_filename(found_filename)
  end
end

function M.reopen_closed_file()
  if #_CLOSED_BUFFERS < 1 then return true end

  local last_closed_index = #_CLOSED_BUFFERS
  io.open_file(_CLOSED_BUFFERS[last_closed_index])

  _record_opened_filename(_CLOSED_BUFFERS[last_closed_index])
end

events.connect(events.INITIALIZED, _record_all_opened_filenames)
events.connect(events.FILE_OPENED, _record_opened_filename)
events.connect(events.BUFFER_DELETED, _handle_closed_buffer)


return M
