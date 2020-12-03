local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local naughty = require("naughty")

local function start(widget)
  awful.spawn.with_line_callback("bash /home/gcg/dotfiles/awesome/widgets/power.sh", {
    stdout = function(line)
      local powersave, charging, percentage = line:match("([^,]+),([^,]+),([^,]+)")
      if tonumber(powersave) > 0 then
        widget.markup = '<span color="#FF0000">🚶</span>'
      else
        widget.markup = ""
      end
      if tonumber(charging) == 0 and tonumber(percentage) < 5 then
        naughty.notify({
          title = "I'm dying here",
          text = "PUT ME TO SLEEP!"
        })
      end
    end,
    stderr = function(line)
      naughty.notify({ title= "power/error", text=line })
    end,
    exit = function (reason, exitcode)
      naughty.notify({ title= "power/exited", text=reason })
      start(widget)
    end,
  })
end


local power = wibox.widget.textbox()
start(power)
return power
