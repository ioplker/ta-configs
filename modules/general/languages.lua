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


-- Bash
textadept.file_types.extensions['env'] = 'bash'
textadept.file_types.extensions['env.example'] = 'bash'
textadept.file_types.extensions['nix'] = 'bash'


-- JS++
textadept.file_types.extensions['jspp'] = 'jspp'
textadept.file_types.extensions['js++'] = 'jspp'
