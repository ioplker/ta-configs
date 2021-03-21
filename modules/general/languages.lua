-- Nim-tools
events.connect(events.LEXER_LOADED, function(name)
  if name ~= 'nim' then return end
  require('nim-tools')
end)


-- PlantUML
textadept.file_types.extensions['puml'] = 'plantuml'


-- Metatie
textadept.file_types.extensions['metatie'] = 'metatie'

