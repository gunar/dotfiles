-- {{{ Random Wallpapers

local awful = require("awful")
local gears = require("gears")

function refresh()
  local i = math.random(1,99999)
  local file = "/tmp/wallpaper-" .. i .. ".jpg"
  local width = screen[1].geometry.width
  local height = screen[1].geometry.height
  local commandLine = "wget -O " .. file .. " https://source.unsplash.com/random/" .. width .. "x" .. height
  awful.spawn.easy_async(commandLine, function(stdout, stderr, reason, exit_code)
    local cmd = "mogrify xc:skyblue -fill \"rgba(0,0,0,0.5)\" -draw \"rectangle 0,0 99999,30\" " .. file
    awful.spawn.easy_async(cmd, function(stdout, stderr, reason, exit_code)
      for s = 1, screen.count() do
        gears.wallpaper.maximized(file, s, true)
      end
    end)
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

return refresh
