require('nim-tools/def')
require('nim-tools/use')


local function split(s, delimiter)
  result = {};
  for match in (s..delimiter):gmatch("(.-)"..delimiter) do
    table.insert(result, match);
  end
  return result;
end


local function handle_response(response)
  --ui.print("@@@@@" .. response)
  if response:sub(1, 6) == "usage:" then
    ui.statusbar_text = "nim-tools: ON"
    return
  end

  resp_arr = split(response, "\x09")

  if resp_arr[1] == "def" then
    ui.statusbar_text = "nim-tools: FOUND DEF"
    nimsuggest_handle_def(resp_arr[5], resp_arr[6], resp_arr[7])
  else

    if resp_arr[1] == "use" then
      ui.statusbar_text = "nim-tools: FOUND USE"
      nimsuggest_handle_use(resp_arr[5], resp_arr[6], resp_arr[7])
    end
  end
end

function quit_nimsuggest()
  nimsuggest:write("quit\n")
end

local filename = _G.buffer.filename
ui.statusbar_text = "nim-tools: LOADING"
nimsuggest = os.spawn("nimsuggest " .. filename, handle_response)


keys['f12'] = nimsuggest_find_def
keys['shift+f12'] = nimsuggest_find_use
