-- Standard awesome library
local gears = require("gears")
local cairo = require("lgi").cairo
local awful = require("awful")
awful.rules = require("awful.rules")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")


-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = err })
        in_error = false
    end)
end
-- }}}


-- Simple function to load additional LUA files from rc/.
function loadrc(name, mod)
   local success
   local result

   -- Which file? In rc/ or in lib/?
   local path = awful.util.getdir("config") .. "/" ..
      (mod and "lib" or "rc") ..
      "/" .. name .. ".lua"

   -- If the module is already loaded, don't load it again
   if mod and package.loaded[mod] then return package.loaded[mod] end

   -- Execute the RC/module file
   success, result = pcall(function() return dofile(path) end)
   if not success then
      naughty.notify({ title = "Error while loading an RC file",
		       text = "When loading `" .. name ..
			  "`, got the following error:\n" .. result,
		       preset = naughty.config.presets.critical
		     })
      return print("E: error loading RC file '" .. name .. "': " .. result)
   end

   -- Is it a module?
   if mod then
      return package.loaded[mod]
   end

   return result
end


-- {{{ Variable definitions
-- Themes define colours, icons, font and wallpapers.
beautiful.init(awful.util.getdir("config") .. "/" .. "themes/gunar/theme.lua")

-- {{{ Useless gap
beautiful.useless_gap = 10
function useless_gaps_resize(thatmuch)
    local scr = awful.screen.focused()
    scr.selected_tag.gap = scr.selected_tag.gap + tonumber(thatmuch)
    awful.layout.arrange(scr)
end
--- }}}

-- This is used later as the default terminal and editor to run.
terminal = "termite -e tmux"
editor = os.getenv("EDITOR") or "nvim"
editor_cmd = terminal .. " " .. editor

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
local layouts =
{
--    awful.layout.suit.floating,
    awful.layout.suit.tile,
--    awful.layout.suit.tile.left,
--    awful.layout.suit.tile.bottom,
--    awful.layout.suit.tile.top,
--    awful.layout.suit.fair,
--    awful.layout.suit.fair.horizontal,
--    awful.layout.suit.spiral,
--    awful.layout.suit.spiral.dwindle,
--    awful.layout.suit.max,
    awful.layout.suit.max.fullscreen,
--    awful.layout.suit.magnifier
}
-- }}}

-- {{{ Wallpaper
if beautiful.wallpaper then
    for s = 1, screen.count() do
        gears.wallpaper.maximized(beautiful.wallpaper, s, true)
    end
end
-- }}}

-- {{{ Prompts
loadrc("prompt")
-- disabled in favor of xfce4-display-settings
-- loadrc("xrandr")
local refreshWallpaper = loadrc("wallpaper")
-- }}}

-- {{{ Widgets
mytextclock = wibox.widget.textclock("%H:%M | %d ", 10)

require("widgets/heatmon")
heatmon_widget = create_heatmon_widget()

require("widgets/kbdswitcher")
kbdswitcher_widget = create_kbdswitcher_widget()

local assault = require('widgets/assault')
myassault = assault({
  -- need to update these if replacing hardware
  -- too costly to automate
  battery = "BAT0",
  adapter = "AC",
  width = 25,
  stroke_width = 1,
  -- font = "monospace 11",
  font = "DejaVu Sans 9",
  height = 9,
  bolt_width = 0,
  bolt_weight = 0,
  critical_level = 0.1,
  normal_color= "#FFFFFFFF",
  critical_color = "#ff0000",
  charging_color = "#FFFFFFFF"
})

-- }}}

-- {{{ Tags
-- Define a tag table which hold all screen tags.
tags = {}
for s = 1, screen.count() do
    -- Each screen has its own tag table.
    tags[s] = awful.tag({ 1, 2, 3, 4, 5, 6, 7, 8 }, s, layouts[1])
end
-- }}}

-- {{{ Menu
-- Create a laucher widget and a main menu
myawesomemenu = {
	{ "restart", awesome.restart },
	{ "quit", awesome.quit },
	{ "shutdown", terminal .. " -e shutdown" }
}

mymainmenu = awful.menu({ items = { { "awesome", myawesomemenu, beautiful.awesome_icon },
                                    { "open terminal", terminal },
                                    { "refresh wallpaper", refreshWallpaper }
                                  }
                        })


-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
app_folders = { "/usr/share/applications/", "~/.local/share/applications/" }
-- }}}

-- {{{ Wibox

-- Create a wibox for each screen and add it
mywibox = {}
mypromptbox = {}
mylayoutbox = {}
mytaglist = {}
mytaglist.buttons = awful.util.table.join(
                    awful.button({ }, 1, awful.tag.viewonly),
                    awful.button({ modkey }, 1, awful.client.movetotag),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, awful.client.toggletag)
                    )
mytasklist = {}
mytasklist.buttons = awful.util.table.join(
  awful.button({ }, 1, function (c)
    if c == client.focus then
      c.minimized = true
    else
      -- Without this, the following
      -- :isvisible() makes no sense
      c.minimized = false
      if not c:isvisible() then
        awful.tag.viewonly(c:tags()[1])
      end
      -- This will also un-minimize
      -- the client, if needed
      client.focus = c
      c:raise()
    end
  end),
  awful.button({ }, 3, function ()
    if instance then
      instance:hide()
      instance = nil
    else
      instance = awful.menu.clients({
        theme = { width = 250 }
      })
    end
  end),
  awful.button({ }, 4, function ()
    awful.client.focus.byidx(1)
    if client.focus then client.focus:raise() end
  end),
  awful.button({ }, 5, function ()
    awful.client.focus.byidx(-1)
    if client.focus then client.focus:raise() end
  end)
)

for s = 1, screen.count() do
    -- Create a promptbox for each screen
    mypromptbox[s] = awful.widget.prompt()
    -- Create a taglist widget
    mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.filter.all, mytaglist.buttons)

    -- Create a tasklist widget
    mytasklist[s] = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, mytasklist.buttons)

    -- Create the wibox
    mywibox[s] = awful.wibar({ position = "top", height = "28", screen = s })

    -- Widgets that are aligned to the left
    local left_layout = wibox.layout {
      mytaglist[s],
      mypromptbox[s],
      layout = wibox.layout.fixed.horizontal()
    }

    -- Widgets that are aligned to the right
    -- if s == 1 then right_layout:add(wibox.widget.systray()) end
    local right_layout = wibox.layout {
      heatmon_widget,
      myassault,
      kbdswitcher_widget,
      mytextclock,
      layout = wibox.layout.fixed.horizontal()
    }

    -- Now bring it all together (with the tasklist in the middle)
    local layout = wibox.layout {
      left_layout,
      mytasklist[s],
      right_layout,
      layout = wibox.layout.align.horizontal()
    }

    mywibox[s].widget = layout
end
-- }}}

-- {{{ Mouse bindings
function debounce(fn, n)
  local acc = 0
  return function (arg)
    acc = acc + 1
    if acc > n then
      fn(arg)
      acc = 0
    end
  end
end

root.buttons(awful.util.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ modkey }, 4, debounce(function () awful.tag.viewnext(mouse.screen) end, 2)),
    awful.button({ modkey }, 5, debounce(function () awful.tag.viewprev(mouse.screen) end, 2))
))
-- }}}

-- {{{ Spotify
function sendToSpotify(command)
  return function ()
    local isOpen ="ps ax|grep -v grep|grep spotify"
    awful.spawn.easy_async_with_shell(isOpen, function(stdout, stderr, reason, exit_code)
      if exit_code > 0 then
        awful.spawn("spotify")
      end
      awful.spawn("dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player." .. command)
    end)
  end
end
-- }}}

-- {{{ amixer
local getVol = [[amixer|grep -e "[0-9]\%"|head -n 1|grep --only-matching -e "[0-9]\?[0-9]\?[0-9]\%"]]
function incVol()
  awful.spawn.with_shell("amixer set Master 1000+")
  notifyCmd(getVol, "Volume")
end
function decVol()
  awful.spawn.with_shell("amixer set Master 1000-")
  notifyCmd(getVol, "Volume")
end
function toggleMute()
  local cmd  = [[amixer get Master | egrep 'Playback.*?\[o' | egrep -o '\[o.+\]' | head -1]]
  awful.spawn.easy_async_with_shell(cmd, function(stdout, stderr, reason, exit_code) 
    -- % is escape
    if (string.match(stdout, "%[on%]")) then
      notify('mute', 'Volume', 'OFF')
      awful.spawn.with_shell([[
        amixer set Master mute>/dev/null ;
        amixer set Speaker mute>/dev/null ;
        amixer set Headphone mute>/dev/null ;
      ]])
    else
      notify('mute', 'Volume', 'ON')
      awful.spawn.with_shell([[
        amixer set Master unmute>/dev/null ;
        amixer set Speaker unmute>/dev/null ;
        amixer set Headphone unmute>/dev/null ;
      ]])
    end
  end)
  awful.spawn.with_shell("~/dotfiles/scripts/toggleMute ")
end
function muteMic() 
  awful.spawn.with_shell("amixer set Capture nocap")
end
function toggleMicMute()
  awful.spawn.with_shell("amixer set Capture toggle")
end
-- }}}

--- {{{ Revelation
local revelation = require('revelation')
revelation.init() -- must come after beautiful.init
--- }}}

local notifications = {}
function notify(id, title, text) 
  if (notifications[id] == nil) then
    notifications[id] = naughty.notify({ 
      title = title,
      text = text,
      timeout = 1,
      destroy = function() notifications[id] = nil end,
    })
  else
    naughty.reset_timeout(notifications[id])
    naughty.replace_text(notifications[id], title, text)
  end
end
function notifyCmd(cmd, title)
  awful.spawn.easy_async_with_shell(cmd, function(stdout, stderr, reason, exit_code)
    notify(cmd, title, stdout)
  end)
end
function brightness(x)
  awful.spawn("xbacklight " .. x)
  notifyCmd("xbacklight|cut -d. -f 1", "Brightness")
end

-- {{{ Key bindings
globalkeys = awful.util.table.join(globalkeys,
    --- {{{ Useless gap
    awful.key({ modkey, "Control" }, "+", function () useless_gaps_resize(2) end),
    awful.key({ modkey, "Control" }, "-", function () useless_gaps_resize(-2) end),
    -- }}}
    --- {{{ Switcher
    awful.key({ modkey }, "+", revelation),
    --- }}}
    -- {{{ Spotify 
    awful.key({ modkey }, "s", sendToSpotify("PlayPause")), --  XF86AudioPlay
    awful.key({ modkey }, "d", sendToSpotify("Next")), -- XF86AudioNext
    awful.key({ modkey }, "a", sendToSpotify("Previous")), -- XF86AudioPrev
    -- }}}
    -- {{{ Display
    -- this makes xrandr.lua unnecessary
    awful.key({ }, "XF86Display",             function () awful.spawn("xfce4-display-settings") end),
    -- }}}
    -- {{{ Audio
    awful.key({ }, "XF86AudioRaiseVolume",    function () incVol() end),
    awful.key({ }, "XF86AudioLowerVolume",    function () decVol() end),
    awful.key({ }, "XF86AudioMute",           function () toggleMute() end),
    awful.key({ }, "XF86AudioMicMute",           function () toggleMicMute() end),
    awful.key({ }, "XF86Favorites",           function () awful.spawn.with_shell("xlock") end),
    awful.key({ modkey, "Control" }, "Up",    function () incVol() end),
    awful.key({ modkey, "Control" }, "Down",  function () decVol() end),
    -- }}}
    -- {{{ Brightnesshttps://open.spotify.com/track/2YM0kfevj552icN9DisbT9
    awful.key({ }, "XF86MonBrightnessDown",   function () brightness("-dec 5") end),
    awful.key({ }, "XF86MonBrightnessUp",     function () brightness("-inc 5") end),
    awful.key({ modkey, "Control" }, "Left",  function () brightness("-dec 5") end),
    awful.key({ modkey, "Control" }, "Right", function () brightness("-inc 5") end),
    -- }}}https://open.spotify.com/track/2YM0kfevj552icN9DisbT9
    -- {{{ Software
    awful.key({ modkey,           }, "e", function () awful.spawn("thunar") end),
    awful.key({ "Control"         }, "q", function () awful.spawn("catfish") end),
    awful.key({ modkey,           }, "o", function () awful.spawn("chromium --profile-directory=Default") end),
    awful.key({ modkey, "Control" }, "o", function () awful.spawn("chromium --profile-directory=\"Profile 1\"") end),
    awful.key({ modkey,           }, ".", function () awful.spawn("chromium --profile-directory=Default https://web.telegram.org") end),
    -- awful.key({                   }, "Print",       function () awful.spawn("xfce4-screenshooter") end),
    awful.key({                   }, "Print",       function () awful.spawn("shutter") end),
    awful.key({ modkey,           }, "Print",       function () awful.spawn(terminal.." -e /home/gcg/dotfiles/scripts/clipboardImageToCloudApp.rb") end),
    awful.key({ modkey, "Control" }, "m", function () awful.spawn("xfce4-taskmanager") end),
    -- }}}
    awful.key({ modkey,           }, "Left",   awful.tag.viewprev       ),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext       ),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore),

    --- {{{ Screen movement
    -- Switch screen
    awful.key({ modkey,         }, "i", function () awful.screen.focus_bydirection('up') end),
    awful.key({ modkey,         }, "Up", function () awful.screen.focus_bydirection('up') end),
    awful.key({ modkey,         }, "n", function () awful.screen.focus_bydirection('down') end),
    awful.key({ modkey,         }, "Down", function () awful.screen.focus_bydirection('down') end),
    -- Move client
    awful.key({ modkey, "Shift" }, "i",    function () client.focus:move_to_screen() end),
    awful.key({ modkey, "Shift" }, "Up",   function () client.focus:move_to_screen() end),
    awful.key({ modkey, "Shift" }, "n",    function () client.focus:move_to_screen() end),
    awful.key({ modkey, "Shift" }, "Down", function () client.focus:move_to_screen() end),
    --- }}}


    awful.key({ modkey,           }, "j",
        function ()
            awful.client.focus.byidx( 1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "w", function () mymainmenu:show() end),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end),

    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.spawn(terminal) end),
    awful.key({ modkey, "Control" }, "r", awesome.restart),
    -- what will this do now?
  	awful.key({ modkey, "Shift"   }, "q", function () awful.spawn("xfce4-session-logout -lf") end),

    awful.key({ modkey,           }, "l", awful.tag.viewnext),
    awful.key({ modkey,           }, "h", awful.tag.viewprev),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incmwfact(-0.05)         end),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incmwfact( 0.05)         end),
    awful.key({ modkey,           }, "space", function () awful.layout.inc(layouts,  1) end),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(layouts, -1) end),

    -- awful.key({ modkey, "Control" }, "n", awful.client.restore),

    awful.key({ modkey, "Control" },  "x",     function () awful.spawn("xkill") end),

    -- Prompt
    awful.key({ modkey },            "r",     function () mypromptbox[mouse.screen.index]:run() end),

    awful.key({ modkey }, "x",
              function ()
                  awful.prompt.run({ prompt = "Run Lua code: " },
                  mypromptbox[mouse.screen.index].widget,
                  awful.util.eval, nil,
                  awful.util.getdir("cache") .. "/history_eval")
              end),
    -- Menubar
    awful.key({ modkey }, "p", function() menubar.show() end)
)

clientkeys = awful.util.table.join(
    awful.key({ modkey,           }, "f",      function (c) c.fullscreen = not c.fullscreen  end),
    awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end),
    -- awful.key({ modkey,           }, "o",      awful.client.movetoscreen                        ),
    awful.key({ modkey, "Control" }, "t",      function (c) c.ontop = not c.ontop            end),
    awful.key({ modkey,           }, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c.maximized_vertical   = not c.maximized_vertical
        end)
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 8 do
    globalkeys = awful.util.table.join(globalkeys,
        -- View tag only.
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = mouse.screen
                        local tag = screen.tags[i]
                        if tag then
                          tag:view_only()
                        end
                  end),
        -- Toggle tag.
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = mouse.screen
                      local tag = screen.tags[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end),
        -- Move client to tag.
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:move_to_tag(tag)
                          end
                     end
                  end),
        -- Toggle tag.
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              awful.client.toggletag(tag)
                          end
                      end
                  end))
end

for i = 5, 8 do
    globalkeys = awful.util.table.join(globalkeys,
        -- View tag only.
        awful.key({ modkey }, "F" .. i - 4,
                  function ()
                        local screen = mouse.screen
                        local tag = screen.tags[i]
                        if tag then
                          tag:view_only()
                        end
                  end),
        -- Toggle tag.
        awful.key({ modkey, "Control" }, "F" .. i - 4,
                  function ()
                      local screen = mouse.screen
                      local tag = screen.tags[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end),
        -- Move client to tag.
        awful.key({ modkey, "Shift" }, "F" .. i - 4,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:move_to_tag(tag)
                          end
                     end
                  end),
        -- Toggle tag.
        awful.key({ modkey, "Control", "Shift" }, "F" .. i - 4,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              awful.client.toggletag(tag)
                          end
                      end
                  end))
end

clientbuttons = awful.util.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize),
    --- {{{ Scroll
    awful.button({ modkey }, 4, debounce(function (t) awful.tag.viewnext(t.screen) end, 2)),
    awful.button({ modkey }, 5, debounce(function (t) awful.tag.viewprev(t.screen) end, 2))
    --- }}}
)

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     raise = true,
                     keys = clientkeys,
                     buttons = clientbuttons } },
    { rule = { class = "MPlayer" },
      properties = { floating = true } },
    { rule = { class = "pinentry" },
      properties = { floating = true } },
    { rule = { class = "gimp" },
      properties = { floating = true } },
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c, startup)
    -- Enable sloppy focus
    c:connect_signal("mouse::enter", function(c)
        if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
            and awful.client.focus.filter(c) then
            client.focus = c
        end
    end)

    if not startup then
        -- Set the windows at the slave,
        -- i.e. put it at the end of others instead of setting it master.
        -- awful.client.setslave(c)

        -- Put windows in a smart way, only if they does not set an initial position.
        if not c.size_hints.user_position and not c.size_hints.program_position then
            awful.placement.no_overlap(c)
            awful.placement.no_offscreen(c)
        end
    end

    local titlebars_enabled = false
    if titlebars_enabled and (c.type == "normal" or c.type == "dialog") then
        -- buttons for the titlebar
        local buttons = awful.util.table.join(
                awful.button({ }, 1, function()
                    client.focus = c
                    c:raise()
                    awful.mouse.client.move(c)
                end),
                awful.button({ }, 3, function()
                    client.focus = c
                    c:raise()
                    awful.mouse.client.resize(c)
                end)
                )

        -- Widgets that are aligned to the left
        local left_layout = wibox.layout.fixed.horizontal()
        left_layout:add(awful.titlebar.widget.iconwidget(c))
        left_layout:buttons(buttons)

        -- Widgets that are aligned to the right
        local right_layout = wibox.layout.fixed.horizontal()
        right_layout:add(awful.titlebar.widget.floatingbutton(c))
        right_layout:add(awful.titlebar.widget.maximizedbutton(c))
        right_layout:add(awful.titlebar.widget.stickybutton(c))
        right_layout:add(awful.titlebar.widget.ontopbutton(c))
        right_layout:add(awful.titlebar.widget.closebutton(c))

        -- The title goes in the middle
        local middle_layout = wibox.layout.flex.horizontal()
        local title = awful.titlebar.widget.titlewidget(c)
        title.align = 'center'
        middle_layout:add(title)
        middle_layout:buttons(buttons)

        -- Now bring it all together
        local layout = wibox.layout.align.horizontal()
        layout.left = left_layout
        layout.right = right_layout
        layout.middle = middle_layout

        awful.titlebar(c).widget = layout
    end
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}
local function apply_shape(draw, shape, ...)
  local geo = draw:geometry()
  local shape_args = ...

  local img = cairo.ImageSurface(cairo.Format.A1, geo.width, geo.height)
  local cr = cairo.Context(img)

  cr:set_operator(cairo.Operator.CLEAR)
  cr:set_source_rgba(0,0,0,1)
  cr:paint()
  cr:set_operator(cairo.Operator.SOURCE)
  cr:set_source_rgba(1,1,1,1)

  shape(cr, geo.width, geo.height, shape_args)

  cr:fill()

  draw.shape_bounding = img._native

  cr:set_operator(cairo.Operator.CLEAR)
  cr:set_source_rgba(0,0,0,1)
  cr:paint()
  cr:set_operator(cairo.Operator.SOURCE)
  cr:set_source_rgba(1,1,1,1)

  local border = beautiful.base_border_width
  --local titlebar_height = titlebar.is_enabled(draw) and beautiful.titlebar_height or border
  local titlebar_height = border
  gears.shape.transform(shape):translate(
    border, titlebar_height
  )(
    cr,
    geo.width-border*2,
    geo.height-titlebar_height-border,
    --shape_args
    8
  )

  cr:fill()

  draw.shape_clip = img._native

  img:finish()
end

client.connect_signal("property::geometry", function (c)
  if not c.fullscreen then
    gears.timer.delayed_call(apply_shape, c, gears.shape.rounded_rect, 5)
  end
end)







-- Composition Manager for transparency
awful.spawn.with_shell("killall compton ; compton -b")

-- start session
awful.spawn.with_shell("lxsession 2>/dev/null &")
awful.spawn.with_shell("pulseaudio --start")
awful.spawn.with_shell("xss-lock xlock")
muteMic()
