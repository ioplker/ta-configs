require('spellcheck').load('ru_RU')

-- My settings
require('shortcuts').init_defaults()
require('general/buffers')
require('general/languages')

-- FIX: Sync with `shortcuts` module
-- TODO: Replace by integration with `nnn`?
require('textredux').hijack()
-- require('file_diff')

-- FIX: Broke on TA12
--[[
require('ta-tweaks/util')
require('ta-tweaks/ctrl_tab_mru')
]]


if not CURSES then
  view:set_theme('my-base16-tomorrow-night', {font = 'Hack', size = 16})
else
  view:set_theme('term')
end

buffer.use_tabs = false
buffer.tab_width = 2

buffer.auto_c_choose_single = false
buffer.auto_c_multi = buffer.MULTIAUTOC_EACH

textadept.editing.strip_trailing_spaces = true
textadept.editing.highlight_words = textadept.editing.HIGHLIGHT_SELECTED

ui.find.highlight_all_matches = true

view.end_at_last_line = false

view.edge_column = 80
view.edge_mode = view.EDGE_LINE
view.wrap_visual_flags = view.WRAPVISUALFLAG_END

view.fold_by_indentation = true












-- TODO: Save cursor position on buffer auto-saving (when switching buffers)
--[[
  happens when caret is on trailing whitespace at line end
]]
-- TODO: Add `command palette`
-- TODO: Add command to fold/unfold on specific levels
--[[
  go to nested levels with `view.contracted_fold_next`
]]
-- TODO: Place closing bracket only if next symbol is a whitespace (or newline)
-- TODO: Enclose selected text in brackets and quotes (`textadept.editing.enclose(left, right, select)`)
-- TODO: Copy/paste with multiline selection (paste to coresponding line - not all copied text at once; `buffer.MULTIPASTE_EACH`?)
-- TODO: Make comment/uncomment and folding consistent with russian and english layout (remove folding on dot)
-- TODO: Move to virtual line end/home instead of the real one (when line is wrapped)
-- TODO: Do not move (scroll) on toggling buffer's wrap mode (`buffer.anchor`?)
-- TODO: Do not move (scroll) on creating/deleting views (`buffer.anchor`?)

-- TODO: Highlight current view (`view:set_styles()`)
-- TODO: Spellcheck semantic comments too
-- TODO: Spellcheck all text in markdown
-- TODO: LSP for Elixir
-- TODO: Code formatter for Elixir (https://github.com/orbitalquark/textadept-format)
-- TODO: Send signals to `nnn` and `urxvt`:
--[[
  - change cwd of nnn when file focused
  - toggle / go to nnn on `ctrl+e` (don't close app, save size and position)
  - toggle / go to urxvt on `ctrl+t` (don't close app, save size and position)
  - close all apps with TA
  - use sessions as projects
]]

-- TODO: Open apps from nnn in the same i3 place as TA
-- TODO: Extend html lexer to recognize JS in tags' attributes (e.g. for angular or alpinejs)
-- TODO: Snippets for html
-- TODO: Snippets for JS
-- TODO: Snippets for CSS
-- TODO: Snippets for SCSS
-- TODO: Snippets for Elixir
-- TODO: Snippets for PlantUML
-- TODO: Snippets for OpenAPI
-- TODO: Snippets of semantic comments (can determine comment symbols progrmmatically?)
-- TODO: Refactor semantic comments for new lexers (see manual, done for lua)
-- TODO: Make `general` settings more modular
-- TODO: Fix `ctrl_tabs_mru` to remember system buffers without files (like `[Message Buffer]`)

-- TODO: Create readme
-- FIX: Markdown lexer
-- TODO: Create new theme based on `base16-tomorrow-night`
--[[Highlight:
  - semantic comments
  - brackets
  - quotes
  - dot-accessed properties / methods / etc
  - operators (+, -, *, = etc)
]]

-- TODO: Make `ctrl+left`, `ctrl+d` etc to count symbols inside quotes as a word
--[[
  E.g. select all hashes when between them: `print('########')`
]]

-- TODO: Tune menus
-- TODO: Add script to get all semcoms recursively from directory
-- FIX: Folding breaks when commenting fold's parent line
-- FIX: Ctrl+tab and ctrl+shift+tab
-- TODO: Change buffers only in current view

-- TODO: Check buffer changes on undo to remove `*` from buffer's tab if there are no unsaved changes
-- TODO: Don't show `*` in system buffers' (_type ~= nil) tabs
-- TODO: Don't split view when searching in files
-- FIX: Update tabs' labels on dragging in Qt
-- FIX: Enter russian letters in textredux buffers
-- TODO: Create own menu
-- FIX: `Select command` in textredux
