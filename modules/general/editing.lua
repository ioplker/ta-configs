local M = {}

function M.open_home_config()
  io.open_file(_G._USERHOME .. '/init.lua')
end

function M.open_draft()
  io.open_file(_G._USERHOME .. '/DRAFT')
end

function M.cancel_actions()
  buffer.cancel(buffer)

  if not buffer.selection_empty then
    local cur_pos = buffer.selection_end
    buffer.set_selection(buffer, cur_pos, cur_pos)
  end
end

local _COPIED_LINE = ''

function M.cut_text_or_line()
  if buffer.selection_empty then
    buffer.line_cut()
    _COPIED_LINE = ui.clipboard_text
  else
    buffer.cut()
  end
end

function M.copy_text_or_line()
  if buffer.selection_empty then
    buffer.line_copy()
    _COPIED_LINE = ui.clipboard_text
  else
    buffer.copy()
  end
end

function M.paste_text_or_line()
  if _COPIED_LINE ~= '' and _COPIED_LINE == ui.clipboard_text then
    buffer.home()
    buffer.paste()
  else
    _COPIED_LINE = ''
    buffer.paste()
  end
end

-- NOTE: Selects inserted text for continuous duplication
function M.duplicate_lines()
  if buffer.selection_empty then
    buffer.line_duplicate()
  else
    local prev_sel_mode = buffer.selection_mode
    local start_line_num = buffer.line_from_position(buffer.selection_start)
    local end_line_num = buffer.line_from_position(buffer.selection_end)
    local copied_lines_count = end_line_num - start_line_num

    buffer.selection_mode = buffer.SEL_LINES
    buffer.home()
    local lines = buffer.get_sel_text()

    buffer.goto_pos(buffer.selection_end)
    buffer.selection_mode = prev_sel_mode

    buffer.line_end()
    buffer.add_text('\n' .. lines)

    local inserted_start = buffer.position_from_line(end_line_num + 1)
    local inserted_end = buffer.position_from_line(end_line_num + copied_lines_count + 1)

    buffer.set_selection(inserted_end, inserted_start)
    buffer.line_end_display_extend()
  end
end

function M.toggle_comment()
  textadept.editing.toggle_comment()
  buffer.line_down()
end

function M.complete_word()
  if textadept.editing.autocomplete('word') then
    return
  else
    buffer.tab()
  end
end

local _drop_completed_word_tail = function()
  buffer.del_word_right()
end
events.connect(events.AUTO_C_COMPLETED, _drop_completed_word_tail)

return M
