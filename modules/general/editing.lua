local bind = require('shortcuts').bind


-- Indentation
buffer.use_tabs = false
buffer.tab_width = 2


-- Strip trailing spaces on save
textadept.editing.strip_trailing_spaces = true


-- Highlight all occurrences of the selected word
textadept.editing.highlight_words = textadept.editing.HIGHLIGHT_SELECTED


-- Search
ui.find.highlight_all_matches = true


-- Autocomplete for multiline selection
buffer.auto_c_multi = buffer.MULTIAUTOC_EACH


-- Scroll past last line
view.end_at_last_line = false


-- Long line marker
view.edge_column = 80
view.edge_mode = view.EDGE_LINE


-- Line wrap
view.wrap_visual_flags = view.WRAPVISUALFLAG_END

local function toggle_wrap_mode()
  if view.wrap_mode == view.WRAP_WORD then
    view.wrap_mode = view.WRAP_NONE
  else
    view.wrap_mode = view.WRAP_WORD
  end
end

bind('alt+z', toggle_wrap_mode)


-- Go to view by Ctrl+<VIEW NUMBER>
local function go_to_view(number)
  if _G._VIEWS[number] ~= nil then
    ui.goto_view(_G._VIEWS[number])
  end
end

bind('ctrl+1', function() go_to_view(1) end)
bind('ctrl+2', function() go_to_view(2) end)
bind('ctrl+3', function() go_to_view(3) end)
bind('ctrl+4', function() go_to_view(4) end)
bind('ctrl+5', function() go_to_view(5) end)
bind('ctrl+6', function() go_to_view(6) end)
bind('ctrl+7', function() go_to_view(7) end)
bind('ctrl+8', function() go_to_view(8) end)
bind('ctrl+9', function() go_to_view(9) end)


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

bind('ctrl+[', collapse_fold)
bind('ctrl+]', expand_fold)
bind('ctrl+.', toggle_fold)


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

bind('ctrl+D', duplicate_lines)
bind('ctrl+c', copy_text_or_line)
bind('ctrl+v', paste_text_or_line)
bind('ctrl+x', cut_text_or_line)


-- Go to line by number
bind('ctrl+g', textadept.editing.goto_line)


-- Search with selected word
local function start_search_from_selection()
  if not buffer.selection_empty then
    ui.find.find_entry_text = buffer.get_sel_text()
  end

  ui.find.focus()
end

bind('ctrl+f', start_search_from_selection)


-- Change case
local function to_uppercase()
  _G.buffer.upper_case(_G.buffer)
end

local function to_lowercase()
  _G.buffer.lower_case(_G.buffer)
end

bind('ctrl+k', {
  ['ctrl+u'] = to_uppercase,
  ['ctrl+l'] = to_lowercase,
})


-- Save all files
bind('ctrl+alt+s', io.save_all_files)


-- Cancel selection and other intermediate actions on Escape
local function cancel_actions()
  buffer.cancel(buffer)

  if not buffer.selection_empty then
    local cur_pos = buffer.selection_end
    buffer.set_selection(buffer, cur_pos, cur_pos)
  end
end

bind('esc', cancel_actions)
