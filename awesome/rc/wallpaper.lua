-- {{{ Random Wallpapers

-- global: work

local awful = require("awful")
local gears = require("gears")

function refresh()
  local file = "/tmp/wallpaper.jpg"
  local width = screen[1].geometry.width
  local height = screen[1].geometry.height
  local commandLine = "wget -O " .. file .. " https://source.unsplash.com/random/" .. width .. "x" .. height
  awful.spawn.easy_async(commandLine, function(stdout, stderr, reason, exit_code)
        gears.wallpaper.maximized(file, s, true)
        -- prepare wallpaper file for screen lock as i3lock cant use jpg
        awful.spawn.with_shell("convert /tmp/wallpaper.jpg /tmp/wallpaper.png")
  end)
end
refresh()

-- Apply a random wallpaper every aTimer seconds.
local timer = gears.timer({ timeout = 60*60 })
timer:connect_signal("timeout", function()
  refresh()
end)
timer:start()

return refresh
