-- Highlights comments:
-- TODO: reminds to do something
-- FIX: suggests to fix broken code
-- NOTE: provides some informational details or constraints
-- POOP: warns or questions about badly designed code, "hacks"


-- NOTE: Call this before any comments rules as rules order is important!
function add_semcom_rules(comment_prefix, lex, lexer)
  -- Setting up styles - you can change comments' types and colors here
  local comment_colors = {
    todo = lexer.colors.yellow,
    fix = lexer.colors.red,
    note = lexer.colors.blue,
    poop = lexer.colors.purple,
  }

  local token = lexer.token
  local semcom_styles = {}

  for comment_type, fg_color in pairs(comment_colors) do
    semcom_styles[comment_type] = {
      italics = true,
      bold = true,
      back = lexer.colors.dark_black,
      fore = fg_color,
    }

    lex:add_rule(comment_type .. '_comment', token(comment_type .. '_comment', lexer.to_eol(comment_prefix .. ' ' .. string.upper(comment_type) .. ': ')))
    lex:add_style(comment_type .. '_comment', semcom_styles[comment_type])
  end
end
