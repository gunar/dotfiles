local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local naughty = require('naughty')

local ping = 0
local speed = "X"

local SPEED_AVERAGE_INTERVAL_IN_SECONDS = 3
local PING_TIMEOUT_IN_SECONDS = 1

function update(widget)
  local _ping = "<span color=\"" .. (
    (tonumber(ping) or 9999) < 150
      and "#ffffff"
      or "#ff6600"
  ) .. "\">".. ping .. "ms🕐</span>"
  widget.markup = "  <span background=\"#332200\">  " .. speed .. " ┊ " .. _ping  .. "  </span>"
end

function pingUpdate (widget)
  awful.spawn.easy_async_with_shell(
  "ping -c 1 8.8.8.8 -W " .. PING_TIMEOUT_IN_SECONDS .. "|head -n 2|tail -n 1|cut -d'=' -f4-|cut -d' ' -f1|cut -d'.' -f1",
  function(stdout, stderr, reason, exit_code)
    -- remove trailing newline chars
    ping = string.sub(stdout, 0, -2)
    update(widget)
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
  local pingTimer = gears.timer({ timeout = PING_TIMEOUT_IN_SECONDS })
  pingTimer:connect_signal("timeout", function() pingUpdate(widget) end)
  pingTimer:start()

  speedUpdate(widget)
  local speedTimer = gears.timer({ timeout = SPEED_AVERAGE_INTERVAL_IN_SECONDS })
  speedTimer:connect_signal("timeout", function() speedUpdate(widget) end)
  speedTimer:start()


  return widget
end

return create_widget()
