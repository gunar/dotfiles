-- TODO Refactor as https://awesomewm.org/apidoc/classes/awful.widget.watch.html
local wibox = require("wibox")
local awful = require("awful")
local gears = require('gears')
local naughty = require("naughty")

function hex(inp)
  return inp > 16 and string.format("%X", inp) or string.format("0%X", inp)
end

local notifications = {}
function notify(id, title, text) 
  if (notifications[id] == nil) then
    notifications[id] = naughty.notify({ 
      title = title,
      text = text,
      preset = naughty.config.presets.critical,
      timeout = 1,
      destroy = function() notifications[id] = nil end,
    })
  else
    naughty.reset_timeout(notifications[id])
    naughty.replace_text(notifications[id], title, text)
  end
end

function update_heatmon (widget)
  local output = {} -- output buffer
  local h = io.popen('sensors')
  local line = h:read()
  local temp = 0;
  while line do
    for key, value in string.gmatch(line, "(.+):[ ]+[+](%d+).*") do
      if key == "Package id 0" then
        temp = tonumber(value)
      end
    end
    line = h:read()
  end
  h:close()
  table.insert(
    output,
    "<span color=\"#" .. hex(math.ceil(255 * temp / 105)) .. hex(math.ceil(255 * (105 - temp) / 105)) .. "00\">  " .. temp .. "&#8451;  </span>"
  )
  widget.markup = table.concat(output," ")
  if temp > 80 then
    notify("highTemp", "Temprerature too high", "Are you sure the fan is on?")
  end

  awful.spawn.easy_async_with_shell(
    "systemctl status thinkfan|grep 'running'",
    function(stdout, stderr, reason, exit_code)
      if exit_code > 0 then
        notify('thinkfan', 'thinkfan is off!', 'Please try to restart it.')
      end
  end)

  awful.spawn.easy_async_with_shell(
  'cat /proc/acpi/ibm/fan | head -n 2 | tail -n 1 | cut -f3',
  function(stdout, stderr, reason, exit_code)
    local speed = tonumber(stdout)
    if temp > 50 and speed < 1 then
      notify('highTempFanOff', 'High temp but fan is off!', stdout)
    end
  end)

end

function create_heatmon_widget()
  -- Define widgegt
  heatmon = wibox.widget.textbox()

  -- init the widget
  update_heatmon(heatmon)

  local timer = gears.timer({ timeout = 1 })
  timer:connect_signal("timeout", function()
    update_heatmon( heatmon )
  end)
  timer:start()

  return heatmon
end
