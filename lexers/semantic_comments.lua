-- Highlights comments:
-- TODO: reminds to do something
-- FIX: suggests to fix broken code
-- NOTE: provides some informational details or constraints
-- POOP: warns or questions about badly designed code, "hacks"


-- Lexer init stuff
local lexer = require('lexer')
local token, word_match = lexer.token, lexer.word_match
local P, S = lpeg.P, lpeg.S

local lex = lexer.new('semantic_comments')


-- TODO: Support multi-line comments
-- TODO: Skip inside strings
-- FIX: Style the comment prefix (`--`, `#`, `//` etc) - see `----(color check)` comments
----(color check) POOP: check
-- General styles
local semcom_style = { ----(color check) POOP: check
  italics = true,
  bold = true,
  back = lexer.colors.dark_black,
}


-- TODO comments
lex:add_rule('todo_comment', token('todo_comment', lpeg.B(' ') * lexer.to_eol('TODO: ')))

local todo_style = semcom_style
todo_style['fore'] = lexer.colors.yellow

lex:add_style('todo_comment', todo_style)


-- FIX comments
lex:add_rule('fix_comment', token('fix_comment', lpeg.B(' ') * lexer.to_eol('FIX: ')))

local fix_style = semcom_style
fix_style['fore'] = lexer.colors.red

lex:add_style('fix_comment', fix_style)


-- NOTE comments
lex:add_rule('note_comment', token('note_comment', lpeg.B(' ') * lexer.to_eol('NOTE: ')))

local note_style = semcom_style
note_style['fore'] = lexer.colors.blue

lex:add_style('note_comment', note_style)


-- POOP comments
lex:add_rule('poop_comment', token('poop_comment', lpeg.B(' ') * lexer.to_eol('POOP: ')))

local poop_style = semcom_style
poop_style['fore'] = lexer.colors.purple

lex:add_style('poop_comment', poop_style)


-- normal comments
lex:add_rule('normal_comment',
  token(lexer.COMMENT,
    lexer.any - (
      lexer.to_eol('TODO: ') +
      lexer.to_eol('FIX: ') +
      lexer.to_eol('NOTE: ') +
      lexer.to_eol('POOP: ')
    )
  )
)

return lex
