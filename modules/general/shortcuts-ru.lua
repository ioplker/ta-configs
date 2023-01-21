-- Intercepts keypresses and maps russian keycodes to english
-- Allows using default shortcuts when in russian keyboard layout
-- To use this module place it at *modules* dir (for example: *modules/configs*)
-- and import it like this: require('configs/shortcuts-ru')

-- Key code map for generic 104-sym keyboard
-- with "йцукен" russian layout and "qwerty" english layout
local ru_en_map = {
  -- From top left to bottom right - without shift pressed
  [1699]=96, [49]=49, [50]=50, [51]=51, [52]=52, [53]=53, [54]=54, [55]=55, [56]=56, [57]=57, [48]=48, [45]=45, [61]=61,
  [1738]=113, [1731]=119, [1749]=101, [1739]=114, [1733]=116, [1742]=121, [1735]=117, [1755]=105, [1757]=111, [1754]=112, [1736]=91, [1759]=93, [92]=92,
  [1734]=97, [1753]=115, [1751]=100, [1729]=102, [1744]=103, [1746]=104, [1743]=106, [1740]=107, [1732]=108, [1750]=59, [1756]=39,
  [1745]=122, [1758]=120, [1747]=99, [1741]=118, [1737]=98, [1748]=110, [1752]=109, [1730]=44, [1728]=46, [46]=47,

  -- From top left to bottom right - with shift pressed
  [1715]=126, [33]=33, [34]=64, [712]=35, [59]=36, [37]=37, [58]=94, [63]=38, [42]=42, [40]=40, [41]=41, [95]=95, [43]=43,
  [1770]=81, [1763]=87, [1781]=69, [1771]=82, [1765]=84, [1774]=89, [1767]=85, [1787]=73, [1789]=79, [1786]=80, [1768]=123, [1791]=125, [47]=124,
  [1766]=65, [1785]=83, [1783]=68, [1761]=70, [1776]=71, [1778]=72, [1775]=74, [1772]=75, [1764]=76, [1782]=58, [1788]=34,
  [1777]=90, [1790]=88, [1779]=67, [1773]=86, [1769]=66, [1780]=78, [1784]=77, [1762]=60, [1760]=62, [44]=63
}

-- See original function in core/keys.lua
-- Intercepts Textadept keypresses for russian keyboard layout.
-- @param code The keycode.
-- @param shift Whether or not the Shift modifier is pressed.
-- @param control Whether or not the Control modifier is pressed.
-- @param alt Whether or not the Alt/option modifier is pressed.
-- @param cmd Whether or not the Command modifier on macOS is pressed.
-- @param caps_lock Whether or not Caps Lock is enabled.
-- @return `true` to stop handling the key; `nil` otherwise.
local function keypress_ru(code, shift, control, alt, cmd, caps_lock)
  -- Uncomment line below to print key code to message buffer
  -- Helpful for editing key map
  -- print(code)
  -- print(code < 256 and (not CURSES or (code ~= 7 and code ~= 13)) and string.char(code) or keys.KEYSYMS[code])

  -- Intercept only ru key with modifier pressed
  if not ru_en_map[code] or (not control and not alt and not cmd) then return end
  local en_key = ru_en_map[code]

  events.emit('keypress', en_key, shift, control, alt, cmd, caps_lock)
end

events.connect(events.KEYPRESS, keypress_ru)


-- Map of russian keys for textredux (for filtering)
-- with "йцукен" russian layout and "qwerty" english layout
keys.KEYSYMS[1105] = 'ё'
keys.KEYSYMS[1025] = 'Ё'
keys.KEYSYMS[8470] = '№'

keys.KEYSYMS[1072] = 'а'
keys.KEYSYMS[1073] = 'б'
keys.KEYSYMS[1074] = 'в'
keys.KEYSYMS[1075] = 'г'
keys.KEYSYMS[1076] = 'д'
keys.KEYSYMS[1077] = 'е'
keys.KEYSYMS[1078] = 'ж'
keys.KEYSYMS[1079] = 'з'
keys.KEYSYMS[1080] = 'и'
keys.KEYSYMS[1081] = 'й'
keys.KEYSYMS[1082] = 'к'
keys.KEYSYMS[1083] = 'л'
keys.KEYSYMS[1084] = 'м'
keys.KEYSYMS[1085] = 'н'
keys.KEYSYMS[1086] = 'о'
keys.KEYSYMS[1087] = 'п'
keys.KEYSYMS[1088] = 'р'
keys.KEYSYMS[1089] = 'с'
keys.KEYSYMS[1090] = 'т'
keys.KEYSYMS[1091] = 'у'
keys.KEYSYMS[1092] = 'ф'
keys.KEYSYMS[1093] = 'х'
keys.KEYSYMS[1094] = 'ц'
keys.KEYSYMS[1095] = 'ч'
keys.KEYSYMS[1096] = 'ш'
keys.KEYSYMS[1097] = 'щ'
keys.KEYSYMS[1098] = 'ъ'
keys.KEYSYMS[1099] = 'ы'
keys.KEYSYMS[1100] = 'ь'
keys.KEYSYMS[1101] = 'э'
keys.KEYSYMS[1102] = 'ю'
keys.KEYSYMS[1103] = 'я'

keys.KEYSYMS[1040] = 'А'
keys.KEYSYMS[1041] = 'Б'
keys.KEYSYMS[1042] = 'В'
keys.KEYSYMS[1043] = 'Г'
keys.KEYSYMS[1044] = 'Д'
keys.KEYSYMS[1045] = 'Е'
keys.KEYSYMS[1046] = 'Ж'
keys.KEYSYMS[1047] = 'З'
keys.KEYSYMS[1048] = 'И'
keys.KEYSYMS[1049] = 'Й'
keys.KEYSYMS[1050] = 'К'
keys.KEYSYMS[1051] = 'Л'
keys.KEYSYMS[1052] = 'М'
keys.KEYSYMS[1053] = 'Н'
keys.KEYSYMS[1054] = 'О'
keys.KEYSYMS[1055] = 'П'
keys.KEYSYMS[1056] = 'Р'
keys.KEYSYMS[1057] = 'С'
keys.KEYSYMS[1058] = 'Т'
keys.KEYSYMS[1059] = 'У'
keys.KEYSYMS[1060] = 'Ф'
keys.KEYSYMS[1061] = 'Х'
keys.KEYSYMS[1062] = 'Ц'
keys.KEYSYMS[1063] = 'Ч'
keys.KEYSYMS[1064] = 'Ш'
keys.KEYSYMS[1065] = 'Щ'
keys.KEYSYMS[1066] = 'Ъ'
keys.KEYSYMS[1067] = 'Ы'
keys.KEYSYMS[1068] = 'Ь'
keys.KEYSYMS[1069] = 'Э'
keys.KEYSYMS[1070] = 'Ю'
keys.KEYSYMS[1071] = 'Я'
