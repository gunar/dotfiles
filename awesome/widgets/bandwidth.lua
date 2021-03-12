local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local naughty = require("naughty")
local beautiful = require("beautiful")
local notify = require("../notify")

local SPEED_AVERAGE_INTERVAL_IN_SECONDS = 0.5

local PING_TIMEOUT_IN_SECONDS = 0.2
local TIME_BETWEEN_PINGS_IN_SECONDS = 0.5
local MAX_PING_IN_MS = PING_TIMEOUT_IN_SECONDS * 1000
local watchdog = gears.timer({ timeout = PING_TIMEOUT_IN_SECONDS + TIME_BETWEEN_PINGS_IN_SECONDS })


local textWidget = wibox.widget {
    widget = wibox.widget.textbox,
    markup = ''
}
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
local graphPing = wibox.widget {
  widget = wibox.widget.graph,
  step_spacing = 0,
  max_value = MAX_PING_IN_MS,
  scale = false,
  background_color = "#00000000",
  color = "#0000FF7F"
}

local function toEmoji(ms)
  if ms then
    if ms < MAX_PING_IN_MS/4 then return "😍"
    elseif ms < MAX_PING_IN_MS/2 then return "😊"
    elseif ms < MAX_PING_IN_MS then return "😶"
    else return "😭"
    end
  end
end

local function updatePingGraph(widget, pingMs)
  widget:add_value(pingMs)
  textWidget.markup = toEmoji(pingMs)
end

local function startPingProcess(graphWidget)
  awful.spawn.with_line_callback("ping -i " .. TIME_BETWEEN_PINGS_IN_SECONDS .. " 8.8.8.8", {
    stdout = function(line)
      watchdog:again()
      local _, offset = line:find("time=")
      local ms = line:match("time=([0-9.]+) ms")
      if not ms then return end
      pingMs = tonumber(ms)
      updatePingGraph(graphWidget, pingMs)
    end,
    exit = function (reason, exitcode)
      startPingProcess(graphWidget)
    end,
  })
end

local function startSpeedProcess(graphDown, graphUp)
  awful.spawn.with_line_callback("bash /home/gcg/dotfiles/awesome/widgets/speed.sh wlp4s0 " .. SPEED_AVERAGE_INTERVAL_IN_SECONDS, {
    stdout = function(line)
      local down, up = line:match("([^,]+),([^,]+)")
      graphDown:add_value(tonumber(down), 1)
      graphUp:add_value(tonumber(up), 1)
    end,
    stderr = function(line)
      naughty.notify({ title= "errror", text=line })
    end,
    exit = function (reason, exitcode)
      naughty.notify({ title= "speed", text="exited" })
      startSpeedProcess(graphDown, graphUp)
    end,
  })
end

-- Recursive function
-- XXX: Is the memory problem due to this recursion is accumulating in the stack?
startSpeedProcess(graphDown, graphUp)

-- XXX: Latency indicator requires a watchdog because we need to transform no-response into high-latency
--      The same doesn't happen with "speed" because no-speed means low-speed already
watchdog:connect_signal("timeout", function()
  -- notify('ping-timeout', 'Latency', 'timed out')
  updatePingGraph(graphPing, MAX_PING_IN_MS)
end)

-- recursive function
startPingProcess(graphPing)
watchdog:start()

return wibox.widget {
  wibox.container.mirror(graphDown, { horizontal = true, vertical = false }),
  wibox.container.mirror(graphUp, { horizontal = true, vertical = false }),
  wibox.container.mirror(graphPing, { horizontal = true, vertical = true }),
  textWidget,
  layout = wibox.layout.stack
}
