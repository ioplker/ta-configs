local M = {}

function M.find_selected()
  if not buffer.selection_empty then
    ui.find.find_entry_text = buffer.get_sel_text()
  end

  ui.find.focus()
end

function M.search_selected_in_files()
  if not buffer.selection_empty then
    ui.find.find_entry_text = buffer.get_sel_text()
  end

  ui.find.focus{in_files = true}
end

function M.goto_next_bookmark()
  textadept.bookmarks.goto_mark(true)
end

function M.goto_prev_bookmark()
  textadept.bookmarks.goto_mark(false)
end

function M.goto_next_buffer()
  view.goto_buffer(_G.view, 1)
end

function M.goto_prev_buffer()
  view.goto_buffer(_G.view, -1)
end

function _goto_buffer(number)
  if _G._BUFFERS[number] then
    view.goto_buffer(view, _G._BUFFERS[number])
  end
end

function M.goto_buffer_1() _goto_buffer(1) end
function M.goto_buffer_2() _goto_buffer(2) end
function M.goto_buffer_3() _goto_buffer(3) end
function M.goto_buffer_4() _goto_buffer(4) end
function M.goto_buffer_5() _goto_buffer(5) end
function M.goto_buffer_6() _goto_buffer(6) end
function M.goto_buffer_7() _goto_buffer(7) end
function M.goto_buffer_8() _goto_buffer(8) end
function M.goto_buffer_9() _goto_buffer(9) end

function _goto_view(number)
  if _G._VIEWS[number] ~= nil then
    ui.goto_view(_G._VIEWS[number])
  end
end

function M.goto_view_1() _goto_view(1) end
function M.goto_view_2() _goto_view(2) end
function M.goto_view_3() _goto_view(3) end
function M.goto_view_4() _goto_view(4) end

function M.split_view_vertically() view:split(true) end
function M.split_view_horizontally() view:split() end
function M.unsplit_view() view:unsplit() end
function M.unsplit_all_views() while view:unsplit() do end end

function M.grow_view()
  if view.size then
    view.size = view.size + view:text_height(1)
  end
end

function M.shrink_view()
  if view.size then
    view.size = view.size - view:text_height(1)
  end
end

function M.reset_zoom()
  view.zoom = 0
end

function M.toggle_wrap_mode()
  if view.wrap_mode == view.WRAP_WORD then
    view.wrap_mode = view.WRAP_NONE
  else
    view.wrap_mode = view.WRAP_WORD
  end
end

function M.toggle_fold(line)
  local line = line or buffer:line_from_position(buffer.current_pos)
  if buffer.line_visible[line] then
    buffer:toggle_fold(line)
    if not buffer.line_visible[line] then
      buffer:goto_line(buffer.fold_parent[line]) -- set caret on parent fold line
    end
  end
end

function M.collapse_fold(line)
  local line = line or buffer:line_from_position(buffer.current_pos)
  if buffer.fold_expanded[line] and buffer.line_visible[line] then
    buffer:toggle_fold(line)      -- colapse fold
    if not buffer.line_visible[line] then
      buffer:goto_line(buffer.fold_parent[line]) -- set caret on parent fold line
    end
  end
end

function M.expand_fold(line)
  local line = line or buffer:line_from_position(buffer.current_pos)
  if not buffer.fold_expanded[line] and buffer.line_visible[line] then
    buffer:toggle_fold(line)
    buffer:goto_line(line+1) -- set caret on the first child line of the fold
  end
end

return M
