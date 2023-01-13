require('spellcheck').load('ru_RU')
require('textredux').hijack()
require('file_diff')
require('ta-tweaks/util')
require('ta-tweaks/ctrl_tab_mru')

-- My settings
require('general/theme')
require('general/editing')
require('general/buffers')
require('general/files')
require('general/languages')
require('general/shortcuts-ru')

-- Lua reset
keys['ctrl+esc'] = reset


-- Open settings (need to remap for other shortcut)
keys['ctrl+,'] = function()
  io.open_file(_G._USERHOME .. '/init.lua')
end


-- Open draft file (for some temp data etc)
keys['alt+d'] = function()
  io.open_file(_G._USERHOME .. '/DRAFT')
end


-- TODO: Save cursor position on buffer auto-saving (when switching buffers)
--  happens when caret is on trailing whitespace at line end
-- TODO: Go to next line on (un)commenting
-- TODO: Don't go to file end on opening
-- TODO: Add command to fold/unfold on specific levels
-- TODO: Place closing bracket only if next symbol is a whitespace (or newline)
-- TODO: Do not copy text to clipboard when dublicating line (select a word, than `ctrl+shift+d` and check clipboard)
-- TODO: Enclose selected text in brackets and quotes (`textadept.editing.enclose(left, right, select)`)
-- TODO: Copy/paste with multiline selection (paste to coresponding line - not all copied text at once; `buffer.MULTIPASTE_EACH`?)
-- TODO: Make comment/uncomment and folding consistent with russian and english layout (remove folding on dot)
-- TODO: Move to virtual line end/home instead of the real one (when line is wrapped)
-- TODO: Do not move (scroll) on toggling buffer's wrap mode (`buffer.anchor`?)
-- TODO: Do not move (scroll) on creating/deleting views (`buffer.anchor`?)

-- TODO: Spellcheck comments too
-- TODO: Spellcheck all text in markdown
-- TODO: LSP for Elixir
-- TODO: Code formatter for Elixir (https://github.com/orbitalquark/textadept-format)
-- TODO: Highlight brackets in lexers generally
-- TODO: Send signals to `nnn` and `urxvt`:
--   - change cwd of nnn when file focused
--   - toggle / go to nnn on `ctrl+e` (don't close app, save size and position)
--   - toggle / go to urxvt on `ctrl+t` (don't close app, save size and position)
--   - close all apps with TA
--   - use sessions as projects

-- TODO: Open apps from nnn in the same i3 place as TA
-- TODO: Extend html lexer to recognize JS in tags' attributes (e.g. for angular or alpinejs)
-- TODO: Snippets for html
-- TODO: Snippets for JS
-- TODO: Snippets for Elixir
-- TODO: Snippets for PlantUML
-- TODO: Snippets for OpenAPI
-- TODO: Snippets of semantic comments (can determine comment symbols progrmmatically?)
-- TODO: Make `general` settings more modular
-- TODO: Look through default shortcuts for inspiration / tuning / turning off
--   use `keys.command_mode` to entirely turn of default shortcuts and use mine

-- TODO: Create readme
