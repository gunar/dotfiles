local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")

local PING_TIMEOUT_IN_SECONDS = 0.2

local MAX_PING_IN_MS = PING_TIMEOUT_IN_SECONDS * 1000

function timeSinceLastPing()
  return tonumber(os.clock() - lastEcho)  * 10
end

function resetWatchdog()
  lastEcho = os.clock()
  watchdog:again()
end

function update(widget, pingMs)
  local emoji
  if pingMs then
    if pingMs < MAX_PING_IN_MS/4 then emoji = "😍"
    elseif pingMs < MAX_PING_IN_MS/2 then emoji = "😊"
    elseif pingMs < MAX_PING_IN_MS then emoji = "😶"
    else emoji = "😭"
    end
  end
  widget.markup = "  <span color=\""..beautiful.tasklist_fg_normal.."\" background=\"" .. beautiful.tasklist_bg_focus .. "\">  "  .. emoji .. "  </span>"
end

function pingUpdate (widget)
  awful.spawn.with_line_callback("ping -i .5 8.8.8.8", {
    stdout = function(line)
      resetWatchdog()
      local _, offset = line:find("time=")
      if not offset then return end
      time = line:sub(offset + 1):gsub("ms", "")
      pingMs = tonumber(time)
      update(widget, pingMs)
    end,
    exit = function (reason, exitcode)
      pingUpdate(widget)
    end,
  })
end

function create_widget()
  local widget = wibox.widget.textbox()
  -- recursive function
  pingUpdate(widget)
  watchdog = gears.timer({ timeout = PING_TIMEOUT_IN_SECONDS })
  watchdog:connect_signal("timeout", function()
    if timeSinceLastPing() > PING_TIMEOUT_IN_SECONDS then
      update(widget, MAX_PING_IN_MS)
    end
  end)
  watchdog:start()
  return widget
end

return create_widget()
