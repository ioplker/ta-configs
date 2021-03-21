function nimsuggest_find_use()
  local filename = _G.buffer.filename
  local pos = _G.buffer.current_pos
  local line = _G.buffer.line_from_position(pos)
  local col = _G.buffer.column[pos]

  --ui.print("use " .. filename .. ":" .. line .. ":" .. col .. "\n")
  --nimsuggest:write("use " .. filename .. ":" .. line .. ":" .. col .. "\n")
end

function nimsuggest_handle_use(filename, line, col)
  --ui.print("handling use")
  --io.open_file(filename)
--
--  local pos = _G.buffer.find_column(line, col) + 1
--  _G.buffer.goto_pos(pos)
end
