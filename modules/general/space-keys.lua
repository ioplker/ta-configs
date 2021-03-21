keys.space_mode = {
  ['h'] = buffer.char_left,
  ['k'] = buffer.line_up,
  ['j'] = buffer.line_down,
  ['l'] = buffer.char_right,
  ['esc'] = function()
    keys.mode = nil
    ui.statusbar_text = 'NORMAL MODE'
  end
}

keys['esc'] = function()
  keys.mode = nil
  ui.statusbar_text = 'NORMAL MODE'
end

-- For testing ('alt+space' won't work')
keys['ctrl+space'] = function()
  keys.mode = 'space_mode'
  ui.statusbar_text = 'SPACE MODE'
end

events.connect(events.UPDATE_UI, function()
  if keys.mode == 'space_mode' then
    ui.statusbar_text = 'SPACE MODE'
  else
    ui.statusbar_text = 'NORMAL MODE'
  end
end)
keys.mode = nil -- default mode
