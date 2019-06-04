local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")

local SPEED_AVERAGE_INTERVAL_IN_SECONDS = 3
local speed = "X"

function speedUpdate(widget)
  awful.spawn.easy_async_with_shell(
  "~/dotfiles/awesome/widgets/speed.sh wlp4s0 " .. SPEED_AVERAGE_INTERVAL_IN_SECONDS,
  function(stdout, stderr, reason, exit_code)
    -- remove trailing newline chars
    local speed = string.sub(stdout, 0, -2)
    widget.markup = "  <span color=\""..beautiful.tasklist_fg_normal.."\" background=\"" .. beautiful.tasklist_bg_focus .. "\">  " .. speed .. "  </span>"
  end)
end

function create_widget()
  local widget = wibox.widget.textbox()
  speedUpdate(widget)
  -- TODO Refactor as https://awesomewm.org/apidoc/classes/awful.widget.watch.html
  local speedTimer = gears.timer({ timeout = SPEED_AVERAGE_INTERVAL_IN_SECONDS })
  speedTimer:connect_signal("timeout", function() speedUpdate(widget) end)
  speedTimer:start()


  return widget
end

return create_widget()
