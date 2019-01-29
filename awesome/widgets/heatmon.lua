-- TODO Refactor as https://awesomewm.org/apidoc/classes/awful.widget.watch.html
local wibox = require("wibox")
local gears = require('gears')

function hex(inp)
  return inp > 16 and string.format("%X", inp) or string.format("0%X", inp)
end

function update_heatmon (widget)
  local output = {} -- output buffer
  local h = io.popen('sensors')
  local line = h:read()
  local temp = 0;
  while line do
    for key, value in string.gmatch(line, "(.+):[ ]+[+](%d+).*") do
      if key == "Package id 0" then
        temp = value
      end
    end
    line = h:read()
  end
  h:close()
  table.insert(output, "<span color=\"#"
  .. hex(math.ceil(255 * tonumber(temp) / 105))
  .. hex(math.ceil(255 * (105 - tonumber(temp)) / 105))
  .. "00\">  " .. temp .. "&#8451;  </span>")
  widget.markup = table.concat(output," ")
end

function create_heatmon_widget()
  -- Define widgegt
  heatmon = wibox.widget.textbox()
  -- heatmon.align = "right"

  -- init the widget
  update_heatmon(heatmon)

  local timer = gears.timer({ timeout = 1 })
  timer:connect_signal("timeout", function()
    update_heatmon( heatmon )
  end)
  timer:start()

  return heatmon
end
