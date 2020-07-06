-- TODO Refactor as https://awesomewm.org/apidoc/classes/awful.widget.watch.html
local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local naughty = require("naughty")

function update_power(widget)
	awful.spawn.easy_async_with_shell(
		"pstate-frequency --get|grep performance",
		function(stdout, stderr, reason, exit_code)
			local isPowerSave = exit_code > 0
			if isPowerSave then
				widget.markup = '<span color="#FF0000">⚡</span>'
			else
				widget.markup = ""
			end
		end
	)

	awful.spawn.easy_async_with_shell(
		"upower -i /org/freedesktop/UPower/devices/battery_BAT0|grep state|grep discharging",
		function(stdout, stderr, reason, exit_code)
			local isDischarging = exit_code == 0
			if isDischarging then
				cmd =
					'sh -c \'upower -i /org/freedesktop/UPower/devices/battery_BAT0|grep percentage | cut -d":" -f2- | cut -d"%" -f1\''
				awful.spawn.with_line_callback(cmd, { stdout = function(line)
					local percentage = tonumber(line)
					if percentage < 5 then
						naughty.notify({
							title = "I'm dying here",
							text = "PUT ME TO SLEEP!"
						})
					end
				end })
			end
		end
	)
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
