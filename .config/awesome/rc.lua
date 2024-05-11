-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Standard awesome library
local awesome = require("awesome")
local root = require("root")
local client = require("client")
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")

-- Widget and layout library
local wibox = require("wibox")

-- Theme handling library
local beautiful = require("beautiful")

-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")

-- Widget library
local vicious = require("vicious")
local lain = require("lain")
local markup = lain.util.markup

-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")

--- Error handling ---

-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({
        preset = naughty.config.presets.critical,
        title = "Oops, there were errors during startup!",
        text = awesome.startup_errors,
    })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function(err)
        -- Make sure we don't go into an endless error loop
        if in_error then
            return
        end
        in_error = true

        naughty.notify({
            preset = naughty.config.presets.critical,
            title = "Oops, an error happened!",
            text = tostring(err),
        })

        in_error = false
    end)
end

--- Variable definitions ---

-- Themes define colours, icons, font and wallpapers.
local theme_path = string.format(
    "%s/.config/awesome/themes/%s/theme.lua",
    os.getenv("HOME"),
    "default"
)
beautiful.init(theme_path)

-- This is used later as the default terminal and editor to run.
local terminal = "wezterm"
local terminal_attached = terminal .. " start -- tmux attach;"
local editor = os.getenv("EDITOR") or "nano"
local editor_cmd = terminal_attached .. " new-window " .. editor
local browser = "firefox-bin"
local awesomedocs = "https://awesomewm.org/doc/api/index.html"

-- Set the locale
-- os.setlocale("en_US.utf8")
os.setlocale("pt_BR.utf8")

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
local modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
    awful.layout.suit.tile,
    awful.layout.suit.spiral.dwindle,
    awful.layout.suit.magnifier,
    awful.layout.suit.fair,
    awful.layout.suit.floating,
}

--- Menu ---

-- Create a launcher widget
local awesome_menu = {
    {
        "hotkeys",
        function()
            hotkeys_popup.show_help(nil, awful.screen.focused())
        end,
    },
    {
        "manual",
        terminal
            .. " start --always-new-process -- "
            .. browser
            .. " "
            .. awesomedocs,
    },
    { "edit config", editor_cmd .. " " .. awesome.conffile },
    { "restart", awesome.restart },
    {
        "quit",
        function()
            awesome.quit()
        end,
    },
}

-- Create a main menu
local main_menu = awful.menu({
    items = {
        { "awesome", awesome_menu, beautiful.awesome_icon },
        { "open terminal", terminal_attached },
    },
})

-- Create a launcher
local launcher = awful.widget.launcher({
    image = beautiful.awesome_icon,
    menu = main_menu,
})

-- Menubar configuration
-- Set the terminal for applications that require it
menubar.utils.terminal = terminal

--- Wibar ---

-- Clock with calendar
local text_clock = wibox.widget.textclock("(%R :: %A, %F) ", 10)
local calendar = awful.widget.calendar_popup.month({
    long_weekdays = true,
})
calendar:attach(text_clock, "tr")

-- CPU
local cpu = lain.widget.cpu({
    settings = function()
        local font = "Terminus 8.5"
        local cpu_num = tonumber(cpu_now.usage)
        local cpu_state = nil

        if cpu_num < 33 then
            cpu_state = markup("#9BCD32", cpu_num)
        elseif cpu_num < 66 then
            cpu_state = markup("#FFBE46", cpu_num)
        else
            cpu_state = markup("#FF4B4B", cpu_num)
        end

        widget:set_markup(markup.font(font, "(cpu% :: " .. cpu_state .. ") "))
    end,
})

-- Network state checker
local netstate = lain.widget.net({
    iface = "eno1", -- Interface to monitor
    settings = function()
        local font = "Terminus 8.5"
        local net_state = nil

        if net_now.state == "up" then
            net_state = markup("#9BCD32", "on")
        else
            net_state = markup("#FF4B4B", "off")
        end

        widget:set_markup(markup.font(font, "(inet :: " .. net_state .. ") "))
    end,
})

-- Memory
local mem_widget = wibox.widget.textbox()
vicious.cache(vicious.widgets.mem)
vicious.register(mem_widget, vicious.widgets.mem, function(_, args)
    local coldef = "</span>"
    local colgre = "<span color='#9BCD32'>"
    local colyel = "<span color='#FFBE46'>"
    local colred = "<span color='#FF4B4B'>"

    local phys = nil
    if args[1] < 33 then
        phys = colgre .. args[1] .. coldef
    elseif args[1] < 66 then
        phys = colyel .. args[1] .. coldef
    else
        phys = colred .. args[1] .. coldef
    end

    local swap = nil
    if args[5] < 33 then
        swap = colgre .. args[5] .. coldef
    elseif args[5] < 66 then
        swap = colyel .. args[5] .. coldef
    else
        swap = colred .. args[5] .. coldef
    end

    return "(phys% ["
        .. phys
        .. "] :: ["
        .. args[2]
        .. " / "
        .. args[3]
        .. "] Mib) (swap% ["
        .. swap
        .. "] :: ["
        .. args[6]
        .. " / "
        .. args[7]
        .. "] Mib) "
end, 10)

-- Add mouse support to tags
local taglist_buttons = gears.table.join(
    awful.button({}, 1, function(t)
        t:view_only()
    end),
    awful.button({ modkey }, 1, function(t)
        if awful.client.focus then
            awful.client.focus:move_to_tag(t)
        end
    end),
    awful.button({}, 3, awful.tag.viewtoggle),
    awful.button({ modkey }, 3, function(t)
        if awful.client.focus then
            awful.client.focus:toggle_tag(t)
        end
    end),
    awful.button({}, 4, function(t)
        awful.tag.viewnext(t.screen)
    end),
    awful.button({}, 5, function(t)
        awful.tag.viewprev(t.screen)
    end)
)

-- Add an app list when the user right-clicks the tasklist
local tasklist_buttons = gears.table.join(
    awful.button({}, 1, function(c)
        if c == awful.client.focus then
            c.minimized = true
        else
            c:emit_signal("request::activate", "tasklist", { raise = true })
        end
    end),
    awful.button({}, 3, function()
        awful.menu.client_list({ theme = { width = 250 } })
    end),
    awful.button({}, 4, function()
        awful.client.focus.byidx(1)
    end),
    awful.button({}, 5, function()
        awful.client.focus.byidx(-1)
    end)
)

local function set_wallpaper(s)
    -- Wallpaper
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end

        gears.wallpaper.maximized(wallpaper, s, true)
    end
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
-- screen.connect_signal("property::geometry", set_wallpaper)

-- Set properties for each screen
awful.screen.connect_for_each_screen(function(s)
    -- Wallpaper
    set_wallpaper(s)

    -- Each screen has its own tag table.
    awful.tag(
        {
            "term",
            "www",
            "music",
            "video",
            "social",
            "virtual",
            "torrent",
            "misc",
        },
        s,
        awful.layout.layouts[1] -- Set starting layout as `tile`
    )

    -- Create an imagebox widget which will contain an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.layoutbox = awful.widget.layoutbox(s)
    s.layoutbox:buttons(gears.table.join(
        awful.button({}, 1, function()
            awful.layout.inc(1)
        end),
        awful.button({}, 3, function()
            awful.layout.inc(-1)
        end),
        awful.button({}, 4, function()
            awful.layout.inc(1)
        end),
        awful.button({}, 5, function()
            awful.layout.inc(-1)
        end)
    ))

    -- Create a taglist widget
    s.taglist = awful.widget.taglist({
        screen = s,
        filter = awful.widget.taglist.filter.all,
        buttons = taglist_buttons,
    })

    -- Create a tasklist widget
    s.tasklist = awful.widget.tasklist({
        screen = s,
        filter = awful.widget.tasklist.filter.currenttags,
        buttons = tasklist_buttons,
    })

    -- Create the wibox
    s.wibox = awful.wibar({ position = "top", screen = s })

    -- Add widgets to the wibox
    s.wibox:setup({
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            launcher,
            s.taglist,
        },
        s.tasklist, -- Middle widget
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            wibox.container.margin(wibox.widget.systray(), 5, 5),
            mem_widget,
            cpu.widget,
            netstate.widget,
            text_clock,
            s.layoutbox,
        },
    })
end)

-- Open the main menu when right-clicking the background
root.buttons(gears.table.join(awful.button({}, 3, function()
    main_menu:toggle()
end)))

-- Key bindings
local globalkeys = gears.table.join(
    awful.key(
        { modkey },
        "Left",
        awful.tag.viewprev,
        { description = "view previous tag", group = "tag" }
    ),

    awful.key(
        { modkey },
        "Right",
        awful.tag.viewnext,
        { description = "view next tag", group = "tag" }
    ),

    awful.key({ modkey }, "j", function()
        awful.client.focus.byidx(1)
    end, { description = "focus next client by index", group = "client" }),

    awful.key({ modkey }, "k", function()
        awful.client.focus.byidx(-1)
    end, { description = "focus previous client by index", group = "client" }),

    -- Layout manipulation
    awful.key({ modkey, "Shift" }, "j", function()
        awful.client.swap.byidx(1)
    end, { description = "swap with next client by index", group = "client" }),

    awful.key(
        { modkey, "Shift" },
        "k",
        function()
            awful.client.swap.byidx(-1)
        end,
        { description = "swap with previous client by index", group = "client" }
    ),

    awful.key({ modkey, "Control" }, "j", function()
        awful.screen.focus_relative(1)
    end, { description = "focus the next screen", group = "screen" }),

    awful.key({ modkey, "Control" }, "k", function()
        awful.screen.focus_relative(-1)
    end, { description = "focus the previous screen", group = "screen" }),

    awful.key(
        { modkey },
        "u",
        awful.client.urgent.jumpto,
        { description = "jump to urgent client", group = "client" }
    ),

    -- Standard program
    awful.key({ modkey }, "Return", function()
        awful.spawn(terminal_attached)
    end, { description = "open a terminal", group = "launcher" }),

    awful.key(
        { modkey, "Control" },
        "r",
        awesome.restart,
        { description = "reload awesome", group = "awesome" }
    ),

    awful.key(
        { modkey, "Shift" },
        "q",
        awesome.quit,
        { description = "quit awesome", group = "awesome" }
    ),

    awful.key({ modkey }, "l", function()
        awful.tag.incmwfact(0.05)
    end, { description = "increase master width factor", group = "layout" }),

    awful.key({ modkey }, "h", function()
        awful.tag.incmwfact(-0.05)
    end, { description = "decrease master width factor", group = "layout" }),

    awful.key({ modkey, "Shift" }, "h", function()
        awful.tag.incnmaster(1, nil, true)
    end, {
        description = "increase the number of master clients",
        group = "layout",
    }),

    awful.key({ modkey, "Shift" }, "l", function()
        awful.tag.incnmaster(-1, nil, true)
    end, {
        description = "decrease the number of master clients",
        group = "layout",
    }),

    awful.key({ modkey, "Control" }, "h", function()
        awful.tag.incncol(1, nil, true)
    end, { description = "increase the number of columns", group = "layout" }),

    awful.key({ modkey, "Control" }, "l", function()
        awful.tag.incncol(-1, nil, true)
    end, { description = "decrease the number of columns", group = "layout" }),

    awful.key({ modkey }, "space", function()
        awful.layout.inc(1)
    end, { description = "select next layout", group = "layout" }),

    awful.key({ modkey, "Shift" }, "space", function()
        awful.layout.inc(-1)
    end, { description = "select previous layout", group = "layout" }),

    awful.key({ modkey, "Control" }, "n", function()
        local c = awful.client.restore()
        -- Focus restored client
        if c then
            c:emit_signal(
                "request::activate",
                "key.unminimize",
                { raise = true }
            )
        end
    end, { description = "restore minimized client", group = "client" }),

    -- Runner
    awful.key({ modkey }, "r", function()
        awful.spawn.with_shell("rofi -show run")
    end, { description = "show the runner", group = "launcher" }),

    -- Menubar
    awful.key({ modkey }, "p", function()
        awful.spawn.with_shell("rofi -show drun")
    end, { description = "show the menubar", group = "launcher" }),

    -- Volume Keys
    awful.key({}, "XF86AudioLowerVolume", function()
        awful.util.spawn("amixer set Master 5%-", false)
    end),

    awful.key({}, "XF86AudioRaiseVolume", function()
        awful.util.spawn("amixer set Master 5%+", false)
    end),

    awful.key({}, "XF86AudioMute", function()
        awful.util.spawn("amixer set Master toggle", false)
    end),

    -- Media Keys
    awful.key({}, "XF86AudioPlay", function()
        awful.util.spawn("playerctl play-pause", false)
    end),

    awful.key({}, "XF86AudioNext", function()
        awful.util.spawn("playerctl next", false)
    end),

    awful.key({}, "XF86AudioPrev", function()
        awful.util.spawn("playerctl previous", false)
    end),

    -- Screenshots
    awful.key({ "Control" }, "Print", function()
        awful.spawn.with_shell("~/.config/awesome/flameshot.sh")
    end),
    awful.key({}, "Print", function()
        awful.util.spawn("flameshot full -c", false)
    end)
)

-- Common key bindings to all clients
local clientkeys = gears.table.join(
    awful.key({ modkey }, "f", function(c)
        c.fullscreen = not c.fullscreen
        c:raise()
    end, { description = "toggle fullscreen", group = "client" }),

    awful.key({ modkey, "Shift" }, "c", function(c)
        c:kill()
    end, { description = "close", group = "client" }),

    awful.key(
        { modkey, "Control" },
        "space",
        awful.client.floating.toggle,
        { description = "toggle floating", group = "client" }
    ),

    awful.key({ modkey, "Control" }, "Return", function(c)
        c:swap(awful.client.getmaster())
    end, { description = "move to master", group = "client" }),

    awful.key({ modkey }, "o", function(c)
        c:move_to_screen()
    end, { description = "move to screen", group = "client" }),

    awful.key({ modkey }, "t", function(c)
        c.ontop = not c.ontop
    end, { description = "toggle keep on top", group = "client" }),

    awful.key({ modkey }, "n", function(c)
        -- The client currently has the input focus, so it cannot be
        -- minimized, since minimized clients can't have the focus.
        c.minimized = true
    end, { description = "minimize", group = "client" }),

    awful.key({ modkey }, "m", function(c)
        c.maximized = not c.maximized
        c:raise()
    end, { description = "(un)maximize", group = "client" }),

    awful.key({ modkey, "Control" }, "m", function(c)
        c.maximized_vertical = not c.maximized_vertical
        c:raise()
    end, { description = "(un)maximize vertically", group = "client" }),

    awful.key({ modkey, "Shift" }, "m", function(c)
        c.maximized_horizontal = not c.maximized_horizontal
        c:raise()
    end, { description = "(un)maximize horizontally", group = "client" }),

    -- Toggle the titlebar
    awful.key({ modkey, "Control" }, "t", function(c)
        awful.titlebar.toggle(c)
    end, { description = "show/hide titlebars", group = "client" })
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    globalkeys = gears.table.join(
        globalkeys,
        -- View tag only.
        awful.key({ modkey }, "#" .. i + 9, function()
            local screen = awful.screen.focused()
            local tag = screen.tags[i]

            if tag then
                tag:view_only()
            end
        end, { description = "view tag #" .. i, group = "tag" }),

        -- Toggle tag display.
        awful.key({ modkey, "Control" }, "#" .. i + 9, function()
            local screen = awful.screen.focused()
            local tag = screen.tags[i]

            if tag then
                awful.tag.viewtoggle(tag)
            end
        end, { description = "toggle tag #" .. i, group = "tag" }),

        -- Move client to tag.
        awful.key(
            { modkey, "Shift" },
            "#" .. i + 9,
            function()
                if client.focus then
                    local tag = client.focus.screen.tags[i]

                    if tag then
                        client.focus:move_to_tag(tag)
                    end
                end
            end,
            { description = "move focused client to tag #" .. i, group = "tag" }
        ),

        -- Toggle tag on focused client.
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9, function()
            if client.focus then
                local tag = client.focus.screen.tags[i]

                if tag then
                    client.focus:toggle_tag(tag)
                end
            end
        end, {
            description = "toggle focused client on tag #" .. i,
            group = "tag",
        })
    )
end

-- Move and resize client with `mod + mouse`
local clientbuttons = gears.table.join(
    awful.button({}, 1, function(c)
        c:emit_signal("request::activate", "mouse_click", { raise = true })
    end),
    awful.button({ modkey }, 1, function(c)
        c:emit_signal("request::activate", "mouse_click", { raise = true })
        awful.mouse.client.move(c)
    end),
    awful.button({ modkey }, 3, function(c)
        c:emit_signal("request::activate", "mouse_click", { raise = true })
        awful.mouse.client.resize(c)
    end)
)

-- Set keys
root.keys(globalkeys)

--- Rules ---

-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will match this rule.
    {
        rule = {},
        properties = {
            border_width = beautiful.border_width,
            border_color = beautiful.border_normal,
            focus = awful.client.focus.filter,
            raise = true,
            keys = clientkeys,
            buttons = clientbuttons,
            screen = awful.screen.preferred,
            placement = awful.placement.no_overlap
                + awful.placement.no_offscreen,
        },
    },

    -- Floating clients.
    {
        rule_any = {
            instance = {
                "DTA", -- Firefox addon DownThemAll.
                "copyq", -- Includes session name in class.
                "pinentry",
            },
            class = {
                "Arandr",
                "Blueman-manager",
                "Gpick",
                "Kruler",
                "MessageWin", -- kalarm.
                "Sxiv",
                "Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
                "Wpa_gui",
                "veromix",
                "xtightvncviewer",
                "Nemo",
                "baobab",
                "gwenview",
                "Mousepad",
                "digikam",
                "showfoto",
            },

            -- Note that the name property shown in xprop might be set slightly after creation of the client
            -- and the name shown there might not match defined rules here.
            name = {
                "Event Tester", -- xev.
            },
            role = {
                "AlarmWindow", -- Thunderbird's calendar.
                "ConfigManager", -- Thunderbird's about:config.
                "pop-up", -- e.g. Google Chrome's (detached) Developer Tools.
            },
        },
        properties = { floating = true },
    },

    -- Remove titlebars to normal clients and dialogs
    {
        rule_any = { type = { "normal", "dialog" } },
        properties = { titlebars_enabled = false },
    },

    -- Add titlebars to certain clients
    {
        rule_any = {
            class = {
                "Nemo",
                "baobab",
                "gwenview",
                "Navigator",
                "Mousepad",
                "digikam",
                "showfoto",
            },
        },
        properties = { titlebars_enabled = true },
    },

    -- Make Firefox Picture-in-Picture appear in all tags
    {
        rule = { name = "Picture-in-Picture" },
        properties = {
            floating = true,
            above = true,
            sticky = true,
            maximized = false,
        },
    },

    -- Set wezterm to always map on the tag named "term" on screen 1.
    {
        rule = { class = "org.wezfurlong.wezterm" },
        properties = { screen = 1, tag = "term" },
    },

    -- Set Firefox to always map on the tag named "www" on screen 1.
    {
        rule = { class = "firefox" },
        properties = { screen = 1, tag = "www" },
    },

    -- Set Google Chrome to always map on the tag named "www" on screen 1.
    {
        rule = { class = "Google-chrome" },
        properties = { screen = 1, tag = "www" },
    },

    -- Set qBittorrent to always map on the tag named "torrent" on screen 1.
    {
        rule = { class = "qBittorrent" },
        properties = { screen = 1, tag = "torrent" },
    },

    -- Set Spotify to always map on the tag named "music" on screen 1.
    {
        rule = { class = "Spotify" },
        properties = { screen = 1, tag = "music" },
    },

    -- Set VLC to always map on the tag named "video" on screen 1.
    {
        rule = { class = "vlc" },
        properties = { screen = 1, tag = "video" },
    },

    -- Set Discord to always map on the tag named "social" on screen 1.
    {
        rule = { class = "discord" },
        properties = { screen = 1, tag = "social" },
    },

    -- Set VirtualBox to always map on the tag named "virtual" on screen 1.
    {
        rule = { class = "Virt-manager" },
        properties = { screen = 1, tag = "virtual" },
    },
}

--- Signals ---

-- Signal function to execute when a new client appears.
client.connect_signal("manage", function(c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    -- if not awesome.startup then awful.client.setslave(c) end

    if
        awesome.startup
        and not c.size_hints.user_position
        and not c.size_hints.program_position
    then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
    -- buttons for the titlebar
    local buttons = gears.table.join(
        awful.button({}, 1, function()
            c:emit_signal("request::activate", "titlebar", { raise = true })
            awful.mouse.client.move(c)
        end),
        awful.button({}, 3, function()
            c:emit_signal("request::activate", "titlebar", { raise = true })
            awful.mouse.client.resize(c)
        end)
    )

    awful.titlebar(c):setup({
        { -- Left
            awful.titlebar.widget.iconwidget(c),
            buttons = buttons,
            layout = wibox.layout.fixed.horizontal,
        },
        { -- Middle
            { -- Title
                align = "center",
                widget = awful.titlebar.widget.titlewidget(c),
            },
            buttons = buttons,
            layout = wibox.layout.flex.horizontal,
        },
        { -- Right
            awful.titlebar.widget.maximizedbutton(c),
            awful.titlebar.widget.ontopbutton(c),
            awful.titlebar.widget.closebutton(c),
            layout = wibox.layout.fixed.horizontal(),
        },
        layout = wibox.layout.align.horizontal,
    })
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
    c:emit_signal("request::activate", "mouse_enter", { raise = false })
end)

client.connect_signal("focus", function(c)
    c.border_color = beautiful.border_focus
end)
client.connect_signal("unfocus", function(c)
    c.border_color = beautiful.border_normal
end)

-- Change borders depending on client state
local function change_border(c)
    if c.maximized == true then
        c.border_width = 0
    else
        c.border_width = beautiful.border_width
        c.border_color = beautiful.border_focus
    end
end
client.connect_signal("property::maximized", function(c)
    change_border(c)
end)
client.connect_signal("focus", function(c)
    change_border(c)
end)

-- Add a listener to windows without a class, apply rules when they get one
client.connect_signal("manage", function(c)
    if c.class == nil then
        c.minimized = true
        c:connect_signal("property::class", function()
            c.minimized = false
            awful.rules.apply(c)
        end)
    end
end)
-- }}}

-- Startup
awful.spawn.with_shell(
    string.format("%s/.config/awesome/autostart.sh", os.getenv("HOME"))
)

-- Run garbage collector regularly to prevent memory leaks
-- gears.timer({
--     timeout = 30,
--     autostart = true,
--     callback = function()
--         collectgarbage()
--     end,
-- })

-- Override client icons
require("icon_customizer")({ delay = 0.2 })
