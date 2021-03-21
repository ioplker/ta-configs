-- Tabs changing
keys['ctrl+pgdn'] = function () view.goto_buffer(_G.view, 1) end
keys['ctrl+pgup'] = function () view.goto_buffer(_G.view, -1) end


-- Readonly buffer
-- NOTE: Changes tab label!
--local ORIGINAL_TAB_LABELS = {}
--
--local SERVICE_BUFFERS = {
--  ['[Message Buffer]'] = '[Message Buffer]',
--  ['Untitled'] = 'Untitled'
--}
--
--local READONLY_MARKER = '[%] '
--
--local function remember_tab_label()
--  ORIGINAL_TAB_LABELS[buffer] = buffer.tab_label
--end
--
--local function update_tab_label()
-- FIX: Make this not hardcoded
--  if SERVICE_BUFFERS[buffer.filename] then return end
--
--  local filename = buffer.filename and buffer.filename:match("([^/]+)$") or 'Untitled'
--
--  if buffer.read_only then
--    if buffer.modify then
--      buffer.tab_label = READONLY_MARKER .. filename .. '*'
--    else
--      buffer.tab_label = READONLY_MARKER .. filename
--    end
--  else
--    if buffer.modify then
--      buffer.tab_label = filename .. '*'
--    else
--      buffer.tab_label = filename
--    end
--  end
--end

local function toggle_buffer_readonly()
  --if SERVICE_BUFFERS[buffer.filename] then return end

  buffer.read_only = not buffer.read_only
  --update_tab_label()
end

--events.connect(events.BUFFER_NEW, remember_tab_label)
--events.connect(events.BUFFER_AFTER_SWITCH, update_tab_label)
--events.connect(events.FILE_AFTER_SAVE, update_tab_label)
keys['ctrl+%'] = toggle_buffer_readonly


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
keys['ctrl+T'] = reopen_closed_file
