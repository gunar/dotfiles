-- TODO Refactor as https://awesomewm.org/apidoc/classes/awful.widget.watch.html
local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")
local naughty = require('naughty')

local SPEED_AVERAGE_INTERVAL_IN_SECONDS = 3
local PING_TIMEOUT_IN_SECONDS = 0.2

local MAX_PING_IN_MS = PING_TIMEOUT_IN_SECONDS * 1000
local speed = "X"

function update(widget)
  local ping
  if pingMs and pingMs < MAX_PING_IN_MS/4 then ping = "😍"
  elseif pingMs < MAX_PING_IN_MS/2 then ping = "😊"
  elseif pingMs < MAX_PING_IN_MS then ping = "😶"
  else ping = "😭"
  end
  widget.markup = "  <span color=\""..beautiful.tasklist_fg_normal.."\" background=\"" .. beautiful.tasklist_bg_focus .. "\">  " .. speed ..  "  " .. ping .. "  </span>"
end

function pingUpdate (widget)
  awful.spawn.easy_async_with_shell(
  "ping -c 1 8.8.8.8 -W " .. PING_TIMEOUT_IN_SECONDS .. "|head -n 2|tail -n 1|cut -d'=' -f4-|cut -d' ' -f1|cut -d'.' -f1",
  function(stdout, stderr, reason, exit_code)
    -- remove trailing newline chars
    pingMs = tonumber(string.sub(stdout, 0, -2)) or PING_TIMEOUT_IN_SECONDS * 1000
    update(widget)
    pingUpdate(widget)
  end)
end
function speedUpdate(widget)
  awful.spawn.easy_async_with_shell(
  "~/dotfiles/awesome/widgets/speed.sh wlp4s0 " .. SPEED_AVERAGE_INTERVAL_IN_SECONDS,
  function(stdout, stderr, reason, exit_code)
    -- remove trailing newline chars
    speed = string.sub(stdout, 0, -2)
    update(widget)
  end)
end

function create_widget()
  local widget = wibox.widget.textbox()

  pingUpdate(widget)

  speedUpdate(widget)
  local speedTimer = gears.timer({ timeout = SPEED_AVERAGE_INTERVAL_IN_SECONDS })
  speedTimer:connect_signal("timeout", function() speedUpdate(widget) end)
  speedTimer:start()


  return widget
end

return create_widget()
