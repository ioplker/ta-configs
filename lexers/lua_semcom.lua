require('general/semantic_comments')

-- Loads default lexer and embeds semantic comments lexer into it
local PREFIX = '--'
local LEXER_NAME = 'lua'

return embed_semcom(PREFIX, LEXER_NAME)
