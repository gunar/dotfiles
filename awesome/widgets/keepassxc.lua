local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")

local INTERVAL_IN_SECONDS = 60*15

function doit()
  awful.spawn.easy_async_with_shell(
  "~/dotfiles/scripts/keepassxc_sync.sh",
  function(stdout, stderr, reason, exit_code)
    notify('keepassxc', 'keepassxc', stdout)
    if exit_code > 0 then
      notify('keepassxcerr', 'keepassxcerr', stderr)
    end
  end)
end

function create_widget()
  timer = gears.timer({ timeout = PING_TIMEOUT_IN_SECONDS })
  timer:connect_signal("timeout", function()
    doit()
  end)
  timer:start()
  return widget
end

return create_widget()
