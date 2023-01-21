-- TODO: Insert defaults from other modules in `general/`

local M = {}


--[[ General ]]
-- Reset Lua
M['ctrl+esc'] = reset

-- Open home config
M['ctrl+,'] = function() io.open_file(_G._USERHOME .. '/init.lua') end

-- Open draft file (for some temp data etc)
M['alt+d'] = function() io.open_file(_G._USERHOME .. '/DRAFT') end


--[[ Files & general ]]
M['ctrl+n'] = buffer.new
M['ctrl+s'] = buffer.save
M['ctrl+S'] = buffer.save_as
M['ctrl+r'] = buffer.reload
M['ctrl+w'] = buffer.close
M['ctrl+o'] = io.open_file
M['ctrl+<'] = textadept.session.save
M['ctrl+>'] = textadept.session.load
M['ctrl+q'] = quit


--[[ Editing ]]
M['ctrl+z'] = buffer.undo
M['ctrl+Z'] = buffer.redo
M['ctrl+x'] = buffer.cut
M['ctrl+c'] = buffer.copy
M['ctrl+v'] = buffer.paste
M['ctrl+V'] = textadept.editing.paste_reindent
M['ctrl+d'] = textadept.editing.select_word
M['ctrl+a'] = buffer.select_all
M['ctrl+/'] = textadept.editing.toggle_comment
M['ctrl+shift+down'] = buffer.move_selected_lines_down
M['ctrl+shift+up'] = buffer.move_selected_lines_up


--[[ Navigation ]]
M['alt+left'] = textadept.history.back
M['alt+right'] = textadept.history.forward
M['ctrl+f'] = ui.find.focus
M['f3'] = ui.find.find_next
M['shift+f3'] = ui.find.find_prev
M['alt+r'] = ui.find.replace
M['ctrl+F'] = function() ui.find.focus{in_files = true} end
M['ctrl+g'] = textadept.editing.goto_line


--[[ Tools ]]
M['ctrl+f2'] = textadept.bookmarks.toggle
M['f2'] = function() textadept.bookmarks.goto_mark(true) end
M['shift+f2'] = function() textadept.bookmarks.goto_mark(false) end
M['alt+f2'] = textadept.bookmarks.clear


return M
