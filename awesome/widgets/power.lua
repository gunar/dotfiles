local awful = require("awful")
local wibox = require("wibox")
local gears = require('gears')

function update_power (widget)
  local cmd = "pstate-frequency --get|grep performance"
  awful.spawn.easy_async_with_shell(cmd, function(stdout, stderr, reason, exit_code)
    local isPowerSave = exit_code > 0
    if isPowerSave then
      widget.markup = "<span color=\"#FF0000\">⏾</span>"
    else
      widget.markup = ""
    end
  end)
end

function create_power_widget()
  power = wibox.widget.textbox()
  update_power(power)
  local timer = gears.timer({ timeout = 1 })
  timer:connect_signal("timeout", function()
    update_power(power)
  end)
  timer:start()
  return power
end

return create_power_widget()
