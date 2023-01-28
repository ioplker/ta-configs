-- My rework of original `base16-tomorrow-night` theme for TA 12
-- Base16 Theme: Tomorrow Night
-- http://chriskempson.com/projects/base16/
-- Theme author: Chris Kempson (http://chriskempson.com)
-- Template Repository: https://github.com/rgieseke/base16-textadept
-- Template adapted from Textadept's default templates
-- Copyright 2007-2020 Mitchell mitchell.att.foicica.com. MIT licensed.

local view, colors, styles = view, lexer.colors, lexer.styles

-- NOTE: Color code format is `0xBBGGRR` (not RGB!)
-- POOP: Inverted colors - to use with `picom` compositor to enable dark mode (until there is QT dark mode)
-- Greyscale colors
colors.black       = 0xdee0e2 --> #e2e0de (#1d1f21)
colors.black_mid   = 0xd1d5d7 --> #d7d5d1 (#282a2e)
colors.black_light = 0xbec4c8 --> #c8c4be (#373b41)
colors.grey        = 0x696769 --> #696769 (#969896)
colors.grey_mid    = 0x4b484b --> #4b484b (#b4b7b4)
colors.grey_light  = 0x39373a --> #3a3739 (#c5c8c6)
colors.white       = 0x1f1f1f --> #1f1f1f (#e0e0e0)
colors.white_pure  = 0x000000 --> #000000 (#ffffff)

-- Normal colors
colors.red         = 0x999933 --> #339999 (#cc6666)
colors.brown       = 0xa5975c --> #5c97a5 (#a3685a)
colors.orange      = 0xa06c21 --> #216ca0 (#de935f)
colors.yellow      = 0x8b390f --> #0f398b (#f0c674)
colors.green       = 0x97424a --> #4a4297 (#b5bd68)
colors.cyan        = 0x484175 --> #754148 (#8abeb7)
colors.blue        = 0x415d7e --> #7e5d41 (#81a2be)
colors.purple      = 0x446b4d --> #4d6b44 (#b294bb)


-- POOP: Normal colors (see last poop)
-- Greyscale colors
-- colors.black       = 0x211f1d --> #1d1f21
-- colors.black_mid   = 0x2e2a28 --> #282a2e
-- colors.black_light = 0x413b37 --> #373b41
-- colors.grey        = 0x969896 --> #969896
-- colors.grey_mid    = 0xb4b7b4 --> #b4b7b4
-- colors.grey_light  = 0xc6c8c5 --> #c5c8c6
-- colors.white       = 0xe0e0e0 --> #e0e0e0
-- colors.white_pure  = 0xffffff --> #ffffff
--
-- Normal colors
-- colors.red         = 0x6666cc --> #cc6666
-- colors.brown       = 0x5a68a3 --> #a3685a
-- colors.orange      = 0x5f93de --> #de935f
-- colors.yellow      = 0x74c6f0 --> #f0c674
-- colors.green       = 0x68bdb5 --> #b5bd68
-- colors.cyan        = 0xb7be8a --> #8abeb7
-- colors.blue        = 0xbea281 --> #81a2be
-- colors.purple      = 0xbb94b2 --> #b294bb

-- Default font.
if not font then font = WIN32 and 'Consolas' or OSX and 'Monaco' or 'Monospace' end
if not size then size = not OSX and 10 or 12 end


--[[----------------------------------------------------------------------------
Predefined styles
------------------------------------------------------------------------------]]
styles[view.STYLE_DEFAULT] = {
  font = font, size = size, fore = colors.grey_light, back = colors.black
}
styles[view.STYLE_LINENUMBER] = {fore = colors.blue, back = colors.black}
styles[view.STYLE_BRACELIGHT] = {fore = colors.orange, bold = true}
styles[view.STYLE_BRACEBAD] = {fore = colors.red}
styles[view.STYLE_INDENTGUIDE] = {fore = colors.white}
styles[view.STYLE_CALLTIP] = {fore = colors.grey_mid, back = colors.black_mid}
styles[view.STYLE_FOLDDISPLAYTEXT] = {fore = colors.black_mid}


--[[----------------------------------------------------------------------------
Token styles
------------------------------------------------------------------------------]]
styles[lexer.CLASS] = {fore = colors.yellow}
styles[lexer.COMMENT] = {fore = colors.grey}
styles[lexer.CONSTANT] = {fore = colors.orange}
styles[lexer.CONSTANT_BUILTIN] = {fore = colors.orange, bold = true}
styles[lexer.EMBEDDED] = {fore = colors.brown, back = colors.black_mid}
styles[lexer.ERROR] = {fore = colors.red, italics = true}
styles[lexer.FUNCTION] = {fore = colors.blue}
styles[lexer.FUNCTION_BUILTIN] = {fore = colors.blue, bold = true}
styles[lexer.IDENTIFIER] = {}
styles[lexer.KEYWORD] = {fore = colors.purple}
styles[lexer.LABEL] = {fore = colors.red}
styles[lexer.NUMBER] = {fore = colors.orange}
styles[lexer.OPERATOR] = {fore = colors.grey_light}
styles[lexer.PREPROCESSOR] = {fore = colors.green}
styles[lexer.REGEX] = {fore = colors.cyan}
styles[lexer.STRING] = {fore = colors.green}
styles[lexer.TYPE] = {fore = colors.yellow}
styles[lexer.VARIABLE] = {fore = colors.red}
styles[lexer.VARIABLE_BUILTIN] = {fore = colors.red, bold = true}
styles[lexer.WHITESPACE] = {}
styles[lexer.TAG] = {fore = colors.purple}
styles[lexer.ATTRIBUTE] = {fore = colors.yellow}


--[[----------------------------------------------------------------------------
Caret and Selection Styles
------------------------------------------------------------------------------]]
view:set_sel_back(true, colors.black_light)
view.caret_fore = colors.grey_light
view.caret_line_back = colors.black_mid
view.caret_width = 3


--[[----------------------------------------------------------------------------
Fold Margin
------------------------------------------------------------------------------]]
view:set_fold_margin_color(true, colors.black)
view:set_fold_margin_hi_color(true, colors.black)


--[[----------------------------------------------------------------------------
Markers
------------------------------------------------------------------------------]]
view.marker_back[textadept.bookmarks.MARK_BOOKMARK] = colors.purple
view.marker_back[textadept.run.MARK_WARNING] = colors.orange
view.marker_back[textadept.run.MARK_ERROR] = colors.red
for i = view.MARKNUM_FOLDEREND, view.MARKNUM_FOLDEROPEN do -- fold margin
  view.marker_fore[i] = colors.black
  view.marker_back[i] = colors.grey
  view.marker_back_selected[i] = colors.black_light
end


--[[----------------------------------------------------------------------------
Indicators
------------------------------------------------------------------------------]]
view.indic_fore[ui.find.INDIC_FIND] = colors.grey
view.indic_alpha[ui.find.INDIC_FIND] = 170
-- view.indic_fore[textadept.editing.INDIC_BRACEMATCH] = colors.orange
view.indic_fore[textadept.editing.INDIC_HIGHLIGHT] = colors.white_pure
view.indic_alpha[textadept.editing.INDIC_HIGHLIGHT] = 64
view.indic_fore[textadept.snippets.INDIC_PLACEHOLDER] = colors.orange


--[[----------------------------------------------------------------------------
Call tips
------------------------------------------------------------------------------]]
view.call_tip_fore_hlt = colors.white


--[[----------------------------------------------------------------------------
Long Lines
------------------------------------------------------------------------------]]
view.edge_color = colors.black_light


--[[----------------------------------------------------------------------------
Red, green, and yellow for diff lexer
------------------------------------------------------------------------------]]
-- colors.red = colors.red
-- colors.green = colors.green
-- colors.yellow = colors.yellow


--[[----------------------------------------------------------------------------
Semantic comments
------------------------------------------------------------------------------]]
require('general/semantic-comments').set_semcom_styles(styles)
