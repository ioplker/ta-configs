local lexer = require('lexer')
local token, word_match = lexer.token, lexer.word_match
local P, S = lpeg.P, lpeg.S

local lex = lexer.new('metatie', {fold_by_indentation = true})

-- Whitespace.
lex:add_rule('whitespace', token(lexer.WHITESPACE, lexer.space^1))

-- Keywords.
lex:add_rule('keyword', token(lexer.KEYWORD, word_match([[
  -- `info` section
  title desc link version author

  -- `styles` section
  bgColor titleBgColor titleFgColor titleBdColor

  -- `elementClasses` section
  parent title desc bgColor fgColor bdColor bdWidth icon

  -- `relationClasses` section
  parent title desc lineStyle endStyle lineColor lineWidth

  -- `elements` section
  title desc type class contents parent links

  -- `relations` section

  -- `views` section
  title desc rootEl hideContents depth radius elClasses relClasses forcedEls parent
]], true)))

-- Preprocessors.
lex:add_rule('preprocessor', token(lexer.PREPROCESSOR, word_match([[
  true false
]], true)))

-- Constants.
-- TODO: Mark colors (#ffffff)
local newline = '\\n'
lex:add_rule('constant', token(lexer.CONSTANT, newline + word_match([[
  -- Sections
  info styles elementClasses relationClasses elements relations views
]], true)))

-- Types.
lex:add_rule('type', token(lexer.TYPE, lexer.word))

-- Strings.
lex:add_rule('string', token(lexer.STRING, lexer.range('"')))

-- Comments.
lex:add_rule('comment', token(lexer.COMMENT, lexer.to_eol('`')))

-- Numbers.
lex:add_rule('number', token(lexer.NUMBER, lexer.number))

-- Operators.
-- TODO: Mark links properly (with endings and errors for mixed line styles)
lex:add_rule('operator', token(lexer.REGEX,
  S('=')
))

-- Comment string (with whitespace) for `textadept.editing.toggle_comment()` function
textadept.editing.comment_string.metatie = '` '

return lex
