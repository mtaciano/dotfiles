---------------------------
-- Default awesome theme --
---------------------------

local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local gfs = require("gears.filesystem")
local themes_path = gfs.get_themes_dir()

local theme = {}

theme.font = "Terminus 8.5"

theme.bg_normal = "#191d21"
theme.bg_focus = "#B22222"
theme.bg_urgent = "#ff0000"
theme.bg_minimize = "#721616"
theme.bg_systray = theme.bg_normal

theme.fg_normal = "#d9d9d9"
theme.fg_focus = "#ffffff"
theme.fg_urgent = "#ffffff"
theme.fg_minimize = "#ffffff"

theme.useless_gap = dpi(4)
theme.gap_single_client = true
theme.border_width = dpi(2)
theme.border_normal = "#000000"
theme.border_focus = "#B22222"
theme.border_marked = "#91231c"

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- taglist_[bg|fg]_[focus|urgent|occupied|empty|volatile]
-- tasklist_[bg|fg]_[focus|urgent]
-- titlebar_[bg|fg]_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- mouse_finder_[color|timeout|animate_timeout|radius|factor]
-- prompt_[fg|bg|fg_cursor|bg_cursor|font]
-- hotkeys_[bg|fg|border_width|border_color|shape|opacity|modifiers_fg|label_bg|label_fg|group_margin|font|description_font]
-- Example:
--theme.taglist_bg_focus = "#ff0000"

-- Generate taglist squares:
local taglist_square_size = dpi(6)
theme.taglist_squares_sel =
    theme_assets.taglist_squares_sel(taglist_square_size, theme.fg_normal)
theme.taglist_squares_unsel =
    theme_assets.taglist_squares_unsel(taglist_square_size, theme.fg_normal)

-- Variables set for theming notifications:
-- notification_font
-- notification_[bg|fg]
-- notification_[width|height|margin]
-- notification_[border_color|border_width|shape|opacity]
theme.notification_font = "Terminus 15"
theme.notification_max_height = dpi(150)
theme.notification_max_width = dpi(500)
theme.notification_icon_size = dpi(150)

theme.systray_icon_spacing = dpi(3)

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_submenu_icon = themes_path .. "default/submenu.png"
theme.menu_height = dpi(15)
theme.menu_width = dpi(100)

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.bg_widget = "#cc0000"

-- Define the image to load
theme.titlebar_close_button_normal = themes_path
    .. "default/titlebar/close_normal.png"
theme.titlebar_close_button_focus = themes_path
    .. "default/titlebar/close_focus.png"

theme.titlebar_minimize_button_normal = themes_path
    .. "default/titlebar/minimize_normal.png"
theme.titlebar_minimize_button_focus = themes_path
    .. "default/titlebar/minimize_focus.png"

theme.titlebar_ontop_button_normal_inactive = themes_path
    .. "default/titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive = themes_path
    .. "default/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active = themes_path
    .. "default/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active = themes_path
    .. "default/titlebar/ontop_focus_active.png"

theme.titlebar_sticky_button_normal_inactive = themes_path
    .. "default/titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive = themes_path
    .. "default/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active = themes_path
    .. "default/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active = themes_path
    .. "default/titlebar/sticky_focus_active.png"

theme.titlebar_floating_button_normal_inactive = themes_path
    .. "default/titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive = themes_path
    .. "default/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active = themes_path
    .. "default/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active = themes_path
    .. "default/titlebar/floating_focus_active.png"

theme.titlebar_maximized_button_normal_inactive = themes_path
    .. "default/titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive = themes_path
    .. "default/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active = themes_path
    .. "default/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active = themes_path
    .. "default/titlebar/maximized_focus_active.png"

theme.wallpaper = os.getenv("HOME") .. "/Pictures/wallpaper.jpg"

-- You can use your own layout icons like this:
theme.layout_fairh = themes_path .. "default/layouts/fairhw.png"
theme.layout_fairv = themes_path .. "default/layouts/fairvw.png"
theme.layout_floating = themes_path .. "default/layouts/floatingw.png"
theme.layout_magnifier = themes_path .. "default/layouts/magnifierw.png"
theme.layout_max = themes_path .. "default/layouts/maxw.png"
theme.layout_fullscreen = themes_path .. "default/layouts/fullscreenw.png"
theme.layout_tilebottom = themes_path .. "default/layouts/tilebottomw.png"
theme.layout_tileleft = themes_path .. "default/layouts/tileleftw.png"
theme.layout_tile = themes_path .. "default/layouts/tilew.png"
theme.layout_tiletop = themes_path .. "default/layouts/tiletopw.png"
theme.layout_spiral = themes_path .. "default/layouts/spiralw.png"
theme.layout_dwindle = themes_path .. "default/layouts/dwindlew.png"
theme.layout_cornernw = themes_path .. "default/layouts/cornernww.png"
theme.layout_cornerne = themes_path .. "default/layouts/cornernew.png"
theme.layout_cornersw = themes_path .. "default/layouts/cornersww.png"
theme.layout_cornerse = themes_path .. "default/layouts/cornersew.png"

-- Generate Awesome icon:
theme.awesome_icon =
    theme_assets.awesome_icon(theme.menu_height, theme.bg_focus, theme.fg_focus)

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
-- NOTE: doesn't work
theme.icon_theme = nil

-- Override icons
local icon_dir = "/usr/share/icons/Papirus/128x128/apps/"

theme.ic_icons = {
    ["Chromium"] = icon_dir .. "chromium.svg",
    ["firefox"] = icon_dir .. "firefox.svg",
    ["Zathura"] = icon_dir .. "zathura.svg",
    ["Steam"] = icon_dir .. "steam.svg",
    ["discord"] = icon_dir .. "discord.svg",
    ["Alacritty"] = icon_dir .. "terminal.svg",
    ["kitty"] = icon_dir .. "terminal.svg",
    ["st-256color"] = icon_dir .. "terminal.svg",
    ["Spotify"] = icon_dir .. "spotify.svg",
    ["Nemo"] = icon_dir .. "nemo.svg",
    ["qBittorrent"] = icon_dir .. "qbittorrent.svg",
}

theme.ic_dynamic_classes = { "Alacritty", "kitty", "St", "URxvt", "Termite" }
theme.ic_dynamic_icons = {
    ["- NVIM$"] = icon_dir .. "vim.svg",
    ["- VIM$"] = icon_dir .. "vim.svg",
    ["- TMUX$"] = icon_dir .. "tmux.svg",
    ["^ranger$"] = icon_dir .. "file-manager.svg",
    ["^spt$"] = icon_dir .. "spotify.svg",
    ["^googler$"] = icon_dir .. "google.svg",
    ["- rtv"] = icon_dir .. "reddit.svg",
}

theme.ic_fallback_icon = icon_dir .. "application-default-icon.svg"

return theme
