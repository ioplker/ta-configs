require('general/theme')
require('general/editing')
require('general/buffers')
require('general/files')
require('general/languages')
require('general/shortcuts-ru')
--require('general/space-keys')
require('textredux').hijack()
require('file_diff')
require('spellcheck').load('ru_RU')

-- Lua reset
keys['ctrl+esc'] = reset


-- Open settings (need to remap for other shortcut)
keys['ctrl+,'] = function()
  io.open_file(_G._USERHOME .. '/init.lua')
end
