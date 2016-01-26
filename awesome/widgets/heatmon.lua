local wibox = require("wibox")

function hex(inp)
  return inp > 16 and string.format("%X", inp) or string.format("0%X", inp)
end

function update_heatmon (widget)
  local output = {} -- output buffer
  local h = io.popen('sensors')
  local line = h:read()
  local temp = 0;
  while line do
    for key, value in string.gmatch(line, "(%w+):[ ]+[+](%d+).*") do
      temp = value
      -- if key == "temp1" then
      --     table.insert(output, "<span color=\"#"
      --         .. hex(math.ceil(255 * tonumber(value) / 105))
      --         .. hex(math.ceil(255 * (105 - tonumber(value)) / 105))
      --         .. "00\">" .. value .. "&#8451;</span>")
      -- end
    end
    line = h:read()
  end
  h:close()
  table.insert(output, "<span color=\"#"
  .. hex(math.ceil(255 * tonumber(temp) / 105))
  .. hex(math.ceil(255 * (105 - tonumber(temp)) / 105))
  .. "00\">  " .. temp .. "&#8451;  </span>")
  widget:set_markup(table.concat(output," "))
end

function create_heatmon_widget()
  -- Define widgegt
  heatmon = wibox.widget.textbox()
  -- heatmon:set_align("right")

  -- init the widget
  update_heatmon(heatmon)

  heatmon_timer = timer({timeout = 10})
  heatmon_timer:connect_signal("timeout", function()
    update_heatmon( heatmon )
  end)
  heatmon_timer:start()

  return heatmon
end
