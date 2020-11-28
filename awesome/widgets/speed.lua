local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local naughty = require("naughty")
local beautiful = require("beautiful")

local SPEED_AVERAGE_INTERVAL_IN_SECONDS = 0.5

local PING_TIMEOUT_IN_SECONDS = 0.2
local TIME_BETWEEN_PINGS_IN_SECONDS = 0.5
local MAX_PING_IN_MS = PING_TIMEOUT_IN_SECONDS * 1000
local watchdog = gears.timer({ timeout = PING_TIMEOUT_IN_SECONDS + TIME_BETWEEN_PINGS_IN_SECONDS })
local pingPid


local textWidget = wibox.widget {
    widget = wibox.widget.textbox,
    markup = ''
}

local function resetWatchdog()
  watchdog:again()
end

local function toEmoji(ms)
  if ms then
    if ms < MAX_PING_IN_MS/4 then return "😍"
    elseif ms < MAX_PING_IN_MS/2 then return "😊"
    elseif ms < MAX_PING_IN_MS then return "😶"
    else return "😭"
    end
  end
end

local function update(widget, pingMs)
  widget:add_value(pingMs)
  textWidget.markup = toEmoji(pingMs)
end

local function pingUpdate(graphWidget)
  pingPid = awful.spawn.with_line_callback("ping -i " .. TIME_BETWEEN_PINGS_IN_SECONDS .. " 8.8.8.8", {
    stdout = function(line)
      resetWatchdog()
      local _, offset = line:find("time=")
      local ms = line:match("time=([0-9.]+) ms")
      if not ms then return end
      pingMs = tonumber(ms)
      update(graphWidget, pingMs)
    end,
    exit = function (reason, exitcode)
      if exitcode == 0 then
        pingUpdate(graphWidget)
      end
    end,
  })
end



local function create_widget()
  local graphDown = wibox.widget {
    widget = wibox.widget.graph,
    step_spacing = 0,
    max_value = 8, -- GiB/s
    scale = true,
    background_color = "#00000000",
    stack = true,
    stack_colors = { "#00ff007F" }
  }
  local graphUp = wibox.widget {
    widget = wibox.widget.graph,
    step_spacing = 0,
    max_value = 8, -- GiB/s
    scale = true,
    background_color = "#00000000",
    stack = true,
    stack_colors = { "#ff00007F" }
  }

  local speedTimer = gears.timer({ timeout = SPEED_AVERAGE_INTERVAL_IN_SECONDS })
  speedTimer:connect_signal("timeout", function()
    awful.spawn.easy_async_with_shell(
    "~/dotfiles/awesome/widgets/speed.sh wlp4s0 " .. SPEED_AVERAGE_INTERVAL_IN_SECONDS,
    function(stdout, stderr, reason, exit_code)
      local down, up = string.sub(stdout, 0, -2):match("([^,]+),([^,]+)")
      graphDown:add_value(tonumber(down), 1)
      graphUp:add_value(tonumber(up), 1)
    end)
  end)
  speedTimer:start()


  local graphPing = wibox.widget {
    widget = wibox.widget.graph,
    step_spacing = 0,
    max_value = MAX_PING_IN_MS,
    scale = false,
    background_color = "#00000000",
    color = "#0000FF" -- high latency is very important so we do not add opacity
  }
  -- recursive function
  pingUpdate(graphPing)
  watchdog:connect_signal("timeout", function()
    update(graphPing, MAX_PING_IN_MS)
    if pingPid then
      awful.spawn.easy_async_with_shell(
        'kill -KILL '.. pingPid,
        function()
          pingPid = nil
          pingUpdate(graphPing)
        end
      )
    else
      naughty.notify({ title = 'watchdog timeout but no PID to kill' })
    end
  end)
  watchdog:start()





  return wibox.widget {
    wibox.container.mirror(graphDown, { horizontal = true, vertical = false }),
    wibox.container.mirror(graphUp, { horizontal = true, vertical = false }),
    wibox.container.mirror(graphPing, { horizontal = true, vertical = true }),
    textWidget,
    layout = wibox.layout.stack
  }
end

return create_widget()
