-- Highlights comments:
-- TODO: reminds to do something
-- FIX: suggests to fix broken code
-- NOTE: provides some informational details or constraints
-- POOP: warns or questions about badly designed code, "hacks"


-- NOTE: 1) Add rules into lexer (copy lexer to `.textadept/lexers/`)
--[[ Lua example below
-- Comments.
-- NOTE: <custom-lexer-part>
local COMMENT_PREFIX = '--'

lex:add_rule('todo_comment', lex:tag('todo_comment', lexer.to_eol(COMMENT_PREFIX .. ' TODO:')))
lex:add_rule('fix_comment', lex:tag('fix_comment', lexer.to_eol(COMMENT_PREFIX .. ' FIX:')))
lex:add_rule('note_comment', lex:tag('note_comment', lexer.to_eol(COMMENT_PREFIX .. ' NOTE:')))
lex:add_rule('poop_comment', lex:tag('poop_comment', lexer.to_eol(COMMENT_PREFIX .. ' POOP:')))

local simple_comment = lexer.to_eol(COMMENT_PREFIX)
local block_comment = COMMENT_PREFIX * longstring
lex:add_rule('comment', lex:tag(lexer.COMMENT, block_comment + simple_comment))
-- NOTE: </custom-lexer-part>
]]

-- NOTE: 2) Call `set_semcom_styles` in desired theme (copy theme to `.textadept/themes/` if it is builtin)
--[[
  -- NOTE: Semantic comments
  require('general/semantic-comments').set_semcom_styles(styles)
]]

local M = {}

function M.set_semcom_styles(styles)
  styles['todo_comment'] = {
    italics = true, bold = true,
    -- back = 0x000000, fore = 0x009999,
    back = 0xffffff, fore = 0xff6666,  -- POOP: Inverted for dark mode with `picom`
  }

  styles['fix_comment'] = {
    italics = true, bold = true,
    -- back = 0x000000, fore = 0x000099,
    back = 0xffffff, fore = 0xffff66,  -- POOP: Inverted for dark mode with `picom`
  }

  styles['note_comment'] = {
    italics = true, bold = true,
    -- back = 0x000000, fore = 0xCC6600,
    back = 0xffffff, fore = 0x3399ff,  -- POOP: Inverted for dark mode with `picom`
  }

  styles['poop_comment'] = {
    italics = true, bold = true,
    -- back = 0x000000, fore = 0x990099,
    back = 0xffffff, fore = 0x66ff66,  -- POOP: Inverted for dark mode with `picom`
  }
end

function _paste_semcom(semcom_type)
  local semcom = textadept.editing.comment_string[buffer.lexer_language]
  semcom = semcom .. semcom_type .. ': '
  buffer.line_end()
  buffer.add_text('\n' .. semcom)
end

function M.paste_todo() _paste_semcom('TODO') end
function M.paste_fix() _paste_semcom('FIX') end
function M.paste_note() _paste_semcom('NOTE') end
function M.paste_poop() _paste_semcom('POOP') end

return M
