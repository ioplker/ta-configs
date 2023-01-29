local editing = require('general.editing')
local buffers = require('general.buffers')
local navigation = require('general.navigation')
local semcom = require('general.semantic-comments')
local spellcheck = require('spellcheck')

local M = {}


--[[----------------------------------------------------------------------------
Editing
------------------------------------------------------------------------------]]
M['ctrl+n'] = buffer.new
M['ctrl+s'] = buffer.save
M['ctrl+S'] = buffer.save_as
M['ctrl+r'] = buffer.reload
M['ctrl+w'] = buffer.close
M['ctrl+o'] = io.open_file
M['ctrl+p'] = io.quick_open

M['ctrl+<'] = textadept.session.save
M['ctrl+>'] = textadept.session.load

M['esc'] = editing.cancel_actions
M['ctrl+esc'] = reset
M['ctrl+q'] = quit

M['ctrl+,'] = editing.open_home_config
M['alt+d'] = editing.open_draft

M['ctrl+z'] = buffer.undo
M['ctrl+Z'] = buffer.redo
M['ctrl+x'] = editing.cut_text_or_line
M['ctrl+c'] = editing.copy_text_or_line
M['ctrl+v'] = editing.paste_text_or_line
M['ctrl+D'] = editing.duplicate_lines
M['ctrl+V'] = textadept.editing.paste_reindent
M['ctrl+d'] = textadept.editing.select_word
M['ctrl+a'] = buffer.select_all

M['ctrl+/'] = editing.toggle_comment

M['ctrl+shift+down'] = buffer.move_selected_lines_down
M['ctrl+shift+up'] = buffer.move_selected_lines_up
M['ctrl+up'] = view.line_scroll_up
M['ctrl+down'] = view.line_scroll_down

M['ctrl+k'] = {
  ['ctrl+u'] = buffer.upper_case,
  ['ctrl+l'] = buffer.lower_case,
}

M['\t'] = editing.complete_word


--[[----------------------------------------------------------------------------
Buffers
------------------------------------------------------------------------------]]
M['ctrl+shift+pgup'] = buffers.move_buffer_left
M['ctrl+shift+pgdn'] = buffers.move_buffer_right
M['ctrl+%'] = buffers.toggle_buffer_readonly
M['ctrl+T'] = buffers.reopen_closed_file


--[[----------------------------------------------------------------------------
Navigation
------------------------------------------------------------------------------]]
M['alt+left'] = textadept.history.back
M['alt+right'] = textadept.history.forward
M['ctrl+f'] = navigation.find_selected
M['f3'] = ui.find.find_next
M['shift+f3'] = ui.find.find_prev
M['alt+r'] = ui.find.replace
M['ctrl+F'] = navigation.search_selected_in_files

M['ctrl+E'] = textadept.menu.select_command
M['ctrl+g'] = textadept.editing.goto_line

M['ctrl+\t'] = navigation.goto_next_buffer  -- TODO: Switch in most-recent-order
M['ctrl+pgdn'] = navigation.goto_next_buffer
M['ctrl+shift+\t'] = navigation.goto_prev_buffer  -- TODO: Switch in most-recent-order
M['ctrl+pgup'] = navigation.goto_prev_buffer
M['alt+1'] = navigation.goto_buffer_1
M['alt+2'] = navigation.goto_buffer_2
M['alt+3'] = navigation.goto_buffer_3
M['alt+4'] = navigation.goto_buffer_4
M['alt+5'] = navigation.goto_buffer_5
M['alt+6'] = navigation.goto_buffer_6
M['alt+7'] = navigation.goto_buffer_7
M['alt+8'] = navigation.goto_buffer_8
M['alt+9'] = navigation.goto_buffer_9
M['ctrl+b'] = ui.switch_buffer

M['ctrl+1'] = navigation.goto_view_1
M['ctrl+2'] = navigation.goto_view_2
M['ctrl+3'] = navigation.goto_view_3
M['ctrl+4'] = navigation.goto_view_4

M['ctrl+alt+v'] = navigation.split_view_vertically
M['ctrl+alt+h'] = navigation.split_view_horizontally
M['ctrl+alt+w'] = navigation.unsplit_view
M['ctrl+alt+W'] = navigation.unsplit_all_views

M['alt+kpadd'] = navigation.grow_view
M['alt+kpsub'] = navigation.shrink_view

M['ctrl+kpadd'] = view.zoom_in
M['ctrl+kpsub'] = view.zoom_out
M['ctrl+kp0'] = navigation.reset_zoom

M['alt+z'] = navigation.toggle_wrap_mode
M['ctrl+['] = navigation.collapse_fold
M['ctrl+]'] = navigation.expand_fold
M['ctrl+.'] = navigation.toggle_fold


--[[----------------------------------------------------------------------------
Tools
------------------------------------------------------------------------------]]
M['ctrl+f2'] = textadept.bookmarks.toggle
M['f2'] = navigation.goto_next_bookmark
M['shift+f2'] = navigation.goto_prev_bookmark
M['alt+f2'] = textadept.bookmarks.clear
M['ctrl+ '] = editing.insert_snippet
M['alt+ '] = textadept.snippets.previous

M['alt+/'] = {
  t = semcom.paste_todo,
  f = semcom.paste_fix,
  n = semcom.paste_note,
  p = semcom.paste_poop,
}

M['f7'] = function() spellcheck.check_spelling(true) end
return M
