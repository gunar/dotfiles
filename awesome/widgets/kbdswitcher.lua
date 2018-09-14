-- Keyboard switcher

local wibox = require("wibox")
local awful = require("awful")
local gears = require("gears")

function create_kbdswitcher_widget()
  kbdcfg = {}
  kbdcfg.cmd = "setxkbmap"
  kbdcfg.layout = { {"gunar", "ext", "EX"}, { "br", "" , "BR" }, { "en", "" , "EN" }, { "de", "" , "DE" } } 
  kbdcfg.switch = function ()
    kbdcfg.current = kbdcfg.current % #(kbdcfg.layout) + 1
    local t = kbdcfg.layout[kbdcfg.current]
    os.execute(kbdcfg.cmd .. " " .. t[1] .. " " .. t[2])
  end
  -- default
  kbdcfg.current = 2
  kbdcfg.widget = wibox.widget.textbox()
  kbdcfg.background = wibox.container.background()
  kbdcfg.background.widged = (kbdcfg.widget)
  kbdcfg.background.bg = "#ffffff33"
  kbdcfg.switch()
  -- Mouse bindings
  kbdcfg.widget:buttons(
  awful.util.table.join(awful.button({ }, 1, function () kbdcfg.switch() end))
  )

  local update_kbdswitcher = function ()
    local cmd = "setxkbmap -print | grep xkb_symbols | awk '{print $4}' | awk -F\"+\" '{print $2}'"
    awful.spawn.easy_async_with_shell(cmd, function(stdout, stderr, reason, exit_code)
      local current = stdout
      kbdcfg.widget.text = " " .. current .. " "
    end)
  end

  update_kbdswitcher(kbdcfg)

  local timer = gears.timer({ timeout = 1 })
  timer:connect_signal("timeout", function()
    update_kbdswitcher(kbdcfg)
  end)
  timer:start()

  return kbdcfg.widget

end
