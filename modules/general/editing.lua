-- Indentation
buffer.use_tabs = false
buffer.tab_width = 2


-- Strip trailing spaces on save
textadept.editing.strip_trailing_spaces = true


-- Highlight all occurrences of the selected word
textadept.editing.highlight_words = textadept.editing.HIGHLIGHT_SELECTED


-- Search
ui.find.highlight_all_matches = true


-- Continous word multiselection
-- (like ctrl+d in Sublime Text 3)
keys['ctrl+d'] = textadept.editing.select_word


-- Autocomplete for multiline selection
buffer.auto_c_multi = buffer.MULTIAUTOC_EACH


-- Scroll past last line
view.end_at_last_line = false


-- Long line marker
view.edge_column = 80
view.edge_mode = view.EDGE_LINE


-- Line wrap flags
view.wrap_mode = view.WRAP_WORD
view.wrap_visual_flags = view.WRAPVISUALFLAG_END


-- Go to view by Ctrl+<VIEW NUMBER>
local function switch_to_view(number)
  if _G._VIEWS[number] ~= nil then
    ui.goto_view(_G._VIEWS[number])
  end
end

keys['ctrl+1'] = function() switch_to_view(1) end
keys['ctrl+2'] = function() switch_to_view(2) end
keys['ctrl+3'] = function() switch_to_view(3) end
keys['ctrl+4'] = function() switch_to_view(4) end

-- Folding
local function toggle_fold(line)
  local line = line or buffer:line_from_position(buffer.current_pos)
    if buffer.line_visible[line] then
      buffer:toggle_fold(line)
      if not buffer.line_visible[line] then
        buffer:goto_line(buffer.fold_parent[line]) -- set caret on parent fold line
      end
    end
end

local function collapse_fold(line)
  local line = line or buffer:line_from_position(buffer.current_pos)
    if buffer.fold_expanded[line] and buffer.line_visible[line] then
      buffer:toggle_fold(line)      -- colapse fold
      if not buffer.line_visible[line] then
        buffer:goto_line(buffer.fold_parent[line]) -- set caret on parent fold line
      end
    end
end

local function expand_fold(line)
  local line = line or buffer:line_from_position(buffer.current_pos)
  if not buffer.fold_expanded[line] and buffer.line_visible[line] then
    buffer:toggle_fold(line)
    buffer:goto_line(line+1) -- set caret on the first child line of the fold
  end
end

keys['ctrl+['] = collapse_fold
keys['ctrl+]'] = expand_fold
keys['ctrl+.'] = toggle_fold


-- Lines actions
local COPIED_LINE = ''

local function copy_text_or_line()
  if buffer.selection_empty then
    buffer.line_copy(_G.buffer)
    COPIED_LINE = ui.clipboard_text
  else
    buffer.copy()
  end
end

local function cut_text_or_line()
  if buffer.selection_empty then
    buffer.line_cut(_G.buffer)
    COPIED_LINE = ui.clipboard_text
  else
    buffer.cut()
  end
end

local function paste_text_or_line()
  if COPIED_LINE ~= '' and COPIED_LINE == ui.clipboard_text then
    buffer.home(_G.buffer)
    buffer.paste(_G.buffer)
  else
    COPIED_LINE = ''
    buffer.paste(_G.buffer)
  end
end

local function duplicate_lines()
  if buffer.selection_empty then
    buffer.line_duplicate(_G.buffer)
  else
    local prev_sel_mode = buffer.selection_mode

    buffer.selection_mode = buffer.SEL_LINES
    buffer.home(_G.buffer)
    local lines = buffer.copy(_G.buffer)

    buffer.goto_pos(_G.buffer, buffer.selection_end)
    buffer.selection_mode = prev_sel_mode

    buffer.line_down(_G.buffer)
    buffer.home(_G.buffer)
    buffer.add_text(_G.buffer, '\n')
    buffer.line_up(_G.buffer)
    buffer.paste(_G.buffer)

    buffer.home(_G.buffer)
  end
end

keys['ctrl+D'] = duplicate_lines
keys['ctrl+c'] = copy_text_or_line
keys['ctrl+v'] = paste_text_or_line
keys['ctrl+x'] = cut_text_or_line


-- Go to line by number
keys['ctrl+g'] = textadept.editing.goto_line


-- Search with selected word
local function start_search_from_selection()
  if not buffer.selection_empty then
    ui.find.find_entry_text = buffer.get_sel_text()
  end

  ui.find.focus()
end

keys['ctrl+f'] = start_search_from_selection


-------------- ctrl+tab / ctrl+shift+tab MRU --------------------
--HOLD control key DOWN and press tab = goto previous used buffers (MRU list)
-- ctrl+tab       : forward
-- ctrl+shift+tab : backwards
--example with 5 buffers: CONTROL pressed, TAB pressed 5 times, CONTROL released
--  tab tab tab tab tab
-- 1-  2-  3-  4-  5^  1
-- 2-  1   1   1   1^  2
-- 3   3-  2   2   2^  3
-- 4   4   4-  3   3^  4
-- 5   5   5   5-  4^  5
--
local ctrl_key_down = false
local tab_mru_idx= 0
local mru_buff= {}

local function mru_getbuffpos(b)
  --locate buffer 'b' in the MRU list
  local i= 1
  while i <= #mru_buff do
    if mru_buff[i] == b then
      return i  --return buffer position: 1...
    end
    i=i+1
  end
  return 0  --not found
end

local function mru_buftotop(b)
  --move/add buffer 'b' to the TOP of the MRU list
  if b ~= nil then
    local i= mru_getbuffpos(b)
    if i == 0 then
      --not on the list, add it
      i=#mru_buff+1
      mru_buff[i]= b
    end
    if i > 1 then
      while i > 1 do
        mru_buff[i]= mru_buff[i-1]
        i=i-1
      end
      mru_buff[1]= b
    end
  end
end

--control+tab handler
local function mru_ctrl_tab_handler(shift)
  --we need 2 or more buffers to swap
  if #mru_buff < 2 then
    return --not enought buffers
  end

  if ctrl_key_down then
    --CONTROL key was pressed before 'this' TAB
    --START A NEW SWAP CYCLE
    tab_mru_idx= 1
    ctrl_key_down = false
  end

  local swap
  if shift then
    --ctrl+shift+ tab + .. + tab: swap 'backwards'
    swap= tab_mru_idx
    tab_mru_idx= tab_mru_idx-1
    if swap < 2 then
      tab_mru_idx= #mru_buff
      swap=0
      --ROTATE DOWN (bring bottom to top)
      mru_buftotop(mru_buff[#mru_buff])
    end
  else
    --ctrl+ tab +..+ tab: swap 'foreward'
    tab_mru_idx= tab_mru_idx+1
    swap= tab_mru_idx
    if tab_mru_idx > #mru_buff then
      tab_mru_idx= 1
      swap=0
      --ROTATE UP (send top to bottom)
      local b= mru_buff[1]
      local i= 1
      while i < #mru_buff do
        mru_buff[i]= mru_buff[i+1]
        i=i+1
      end
      mru_buff[i]= b
    end
  end

  if swap > 0 then
    --SWAP 'swap' and top (pos=1)
    --to prevent buffer pushing in BUFFER_AFTER_SWITCH
    local b= mru_buff[1]
    mru_buff[1]= mru_buff[swap]
    mru_buff[swap]= b
  end
  --activate the buffer in the TOP of the MRU list
  view:goto_buffer(mru_buff[1])
end
keys['ctrl+\t'] = function() mru_ctrl_tab_handler(false) end
keys['ctrl+shift+\t']= function() mru_ctrl_tab_handler(true) end

events.connect(events.KEYPRESS, function(code, shift, control, alt, meta)
  if code == 0xFFE3 or code == 0xFFE4 then --control key pressed? (left=65507=FFE3, right=65508=FFE4)
    ctrl_key_down = true
  end
end )

events.connect(events.BUFFER_AFTER_SWITCH, function()
  --move the current buffer to the TOP of the MRU list, pushing down the rest
  mru_buftotop(buffer)
end)

events.connect(events.BUFFER_NEW, function()
  --add a new buffer to the TOP of the MRU list
  --keep in mind that this event is also fired when TA starts
  if #_BUFFERS > #mru_buff then
    mru_buftotop(buffer)
  end
end)

events.connect(events.BUFFER_DELETED, function()
  --remove the closed buffer from the MRU list
  --this event is called AFTER the buffer was deleted (the deleted buffer is NOT in the top of the MRU list)
  --is safer to check ALL the buffers and remove from the MRU list the ones that don't exist any more
  local i= 1
  while i <= #mru_buff do
    if mru_buff[i] ~= nil then
      if _BUFFERS[mru_buff[i]] == nil then
        --this buffer was deleted, remove it from the list
        local j= i
        while j < #mru_buff do
          mru_buff[j]= mru_buff[j+1]
          j=j+1
        end
        mru_buff[j]= nil
      end
      i=i+1
    end
  end
end)

--load existing buffers in the MRU list
if #_BUFFERS > 0 then
  local nb= #_BUFFERS
  local i= 1
  while nb > 0 do
    mru_buff[i]= _BUFFERS[nb]
    nb=nb-1
    i=i+1
  end
  --bring the current buffer to the top of the list
  mru_buftotop(buffer)
end


-- Change case
local function to_uppercase()
  _G.buffer.upper_case(_G.buffer)
end

local function to_lowercase()
  _G.buffer.lower_case(_G.buffer)
end

keys['ctrl+k'] = {
  u = to_uppercase,
  l = to_lowercase,
}
