-- {{{ Random Wallpapers

local awful = require("awful")
local gears = require("gears")

function refresh()
  local i = math.random(1,99999)
  local file = "/tmp/wallpaper-" .. i .. ".jpg"
  local commandLine = "wget -O " .. file .. " https://source.unsplash.com/random"
  awful.spawn.easy_async(commandLine, function(stdout, stderr, reason, exit_code)
    gears.wallpaper.maximized(file, s, true)
  end)
end
refresh()

-- Apply a random wallpaper every changeTime seconds.
changeTime = 3600
wallpaperTimer = timer { timeout = changeTime }
wallpaperTimer:connect_signal("timeout", function()
  wallpaperTimer:stop()
  refresh()
  wallpaperTimer.timeout = changeTime
  wallpaperTimer:start()
end)
wallpaperTimer:start()
