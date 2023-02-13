--[[----------------------------------------------------------------------------
Watch directory for files to open.

If current instance is `forced` (first argument `-f`) - do nothing.

Else - watch `FILES_DIR` for changes with `fswatch` utility.
When new file is created:
  - open files, listed in it (abs path on each line)
  - focus Textadept window
  - delete the file with paths

To open Textadept use bash-script `textadept.sh` near this file.
Also, focus Textadept ("main" instance) when calling this script.
------------------------------------------------------------------------------]]
if arg and arg[1] == "-f" then return end

local FILES_DIR = _USERHOME .. "/.files_to_open"
local textadept_pid = nil
local watcher_proc = nil
local restart_watcher = nil

local open_files = function(file_path, raw_path_list)
  os.spawn("xdotool search --pid " .. textadept_pid .. " | xargs -I % i3-msg '[id=\"%\"] focus'")

  local file_names = {}
  for path in raw_path_list:gmatch("([^\n]+)") do
    table.insert(file_names, path)
  end

  io.open_file(file_names)

  os.spawn("rm " .. file_path)
  watcher_proc:close()
  restart_watcher()
end

local parse_paths_list = function(file_path)
  os.spawn("cat " .. file_path,
    function(raw_path_list)
      open_files(file_path, raw_path_list)
    end
  )
end

restart_watcher = function()
  watcher_proc = os.spawn("fswatch -0 ".. FILES_DIR .. " -1 --event Created", parse_paths_list)
end

events.connect(events.QUIT,
  function()
    if watcher_proc ~= nil then
      watcher_proc:kill()
      watcher_proc:wait()
    end
  end
)


-- Entry point
os.spawn("pidof -s textadept",
  function(pid)
    textadept_pid = pid
    restart_watcher()
  end
)
