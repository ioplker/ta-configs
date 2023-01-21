--[[ Features:
1. Adds `keys.command_mode` with custom defaults (not Textadept's!)
  call `hijack()` to enable and `bind()` to assign functions, e.g.:
  ```
    local shortcuts = require('shortcuts')
    local bind = shortcuts.bind
    shortcuts.hijack()

    bind('ctrl+esc', reset)
  ```

  Key-chains also work
  (but not with single letters inside the chain for now):
  ```
    bind('ctrl+k', {
      ['ctrl+u'] = to_uppercase,
      ['ctrl+l'] = to_lowercase,
    })
  ```

2. Maps russian keys (for `йцукен` <-> `qwerty` keyboard layout)
  see / edit `layouts_map` to fit your keyboard / language
]]
-- TODO: Make key-chains work with single letters inside

local M = {}

-- Key codes `ru -> en` (may be same for some codes)
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

local previous_keycode = nil

-- Custom key mode - all keys' callbacks must be assinged via `bind()`
-- Even Textadept's default ones!
keys.custom_keys = {}

-- See original function in core/keys.lua (`events.connect(events.KEY, function(code, modifiers)`)
local function handle_keypress(code, modifiers)
  if ru_en_map[code] and ru_en_map[code] ~= code then
    -- print('@@@@@@', previous_keycode, code, ru_en_map[code])
    -- POOP: Non-english keys with modifiers always emit twice - so do not emit same key the second time
    if previous_keycode == nil or previous_keycode ~= code then
      events.emit(events.KEY, ru_en_map[code], modifiers)
      previous_keycode = code
    else
      previous_keycode = nil
    end
  end
end

function M.hijack()
  keys.mode = 'custom_keys'

  events.connect(events.UPDATE_UI, function() keys.mode = 'custom_keys' end)
  events.connect(events.KEY, handle_keypress)
end

function M.bind(shortcut, callback_or_mode)
  keys.custom_keys[shortcut] = callback_or_mode
end

local default_bindings = require('shortcuts.bindings')
for k, v in pairs(default_bindings) do
  M.bind(k, v)
end

return M
