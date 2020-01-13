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
