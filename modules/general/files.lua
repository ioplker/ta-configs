-- Open project (or nearby) files
local function open_project_files()
  if not buffer.filename then
    io.open_file()
    return
  end

  if not io.get_project_root() then
    io.quick_open(buffer.filename:match('^(.+)[/\\]'))
  else
    io.quick_open(io.get_project_root())
  end
end

keys['ctrl+p'] = open_project_files
