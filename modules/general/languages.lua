-- Nim-tools
events.connect(events.LEXER_LOADED, function(name)
  if name ~= 'nim' then return end
  require('nim-tools')
end)


-- PlantUML
textadept.file_types.extensions['puml'] = 'plantuml'
textadept.file_types.extensions['iuml'] = 'plantuml'


-- Metatie
textadept.file_types.extensions['metatie'] = 'metatie'


-- Lexers with semantic comments
textadept.file_types.extensions['lua'] = 'lua_semcom'
textadept.file_types.extensions['nim'] = 'nim_semcom'
