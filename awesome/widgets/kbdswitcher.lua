-- Keyboard switcher

local wibox = require("wibox")
local awful = require("awful")

function create_kbdswitcher_widget()
  kbdcfg = {}
  kbdcfg.cmd = "setxkbmap"
  kbdcfg.layout = { { "br", "" , "BR" }, { "en", "" , "EN" }, { "de", "" , "DE" } } 
  kbdcfg.switch = function ()
    kbdcfg.current = kbdcfg.current % #(kbdcfg.layout) + 1
    local t = kbdcfg.layout[kbdcfg.current]
    kbdcfg.widget:set_text(" " .. t[3] .. " ")
    os.execute( kbdcfg.cmd .. " " .. t[1] .. " " .. t[2] )
  end
  -- default
  kbdcfg.current = 0
  kbdcfg.widget = wibox.widget.textbox()
  kbdcfg.background = wibox.widget.background()
  kbdcfg.background:set_widget(kbdcfg.widget)
  kbdcfg.background:set_bg("#ffffff33")
  kbdcfg.switch()
  -- Mouse bindings
  kbdcfg.widget:buttons(
  awful.util.table.join(awful.button({ }, 1, function () kbdcfg.switch() end))
  )

  return kbdcfg.widget

end
