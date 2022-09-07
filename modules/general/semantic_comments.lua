function embed_semcom(prefix, lexer_name)
  local lexer = require('lexer')
  local token = lexer.token

  local parent_lexer = lexer.load(lexer_name)
  local semcom_lexer = lexer.load('semantic_comments')

  local semcom_start_rule = token('semcom_start_tag', prefix)
  local semcom_end_rule = token('semcom_end_tag', '\n')
  parent_lexer:embed(semcom_lexer, semcom_start_rule, semcom_end_rule)

  return parent_lexer
end
