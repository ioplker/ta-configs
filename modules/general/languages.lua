-- Nim-tools
events.connect(events.LEXER_LOADED, function(name)
  if name ~= 'nim' then return end
  require('nim-tools')
end)


-- PlantUML
textadept.file_types.extensions['puml'] = 'plantuml_semcom'
textadept.file_types.extensions['iuml'] = 'plantuml_semcom'


-- Metatie
textadept.file_types.extensions['metatie'] = 'metatie'


-- Lexers with semantic comments
textadept.file_types.extensions['lua'] = 'lua_semcom'

textadept.file_types.extensions['nim'] = 'nim_semcom'
textadept.file_types.extensions['nimble'] = 'nim_semcom'

textadept.file_types.extensions['js'] = 'javascript_semcom'

textadept.file_types.extensions['sh'] = 'bash_semcom'
textadept.file_types.extensions['env'] = 'bash_semcom'
textadept.file_types.extensions['env.example'] = 'bash_semcom'
textadept.file_types.extensions['nix'] = 'bash_semcom'

textadept.file_types.extensions['py'] = 'python_semcom'
