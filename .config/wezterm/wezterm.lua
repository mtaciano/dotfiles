-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This table will hold the configuration
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
    config = wezterm.config_builder()
end

-- This is where you actually apply your config choices
config.term = "wezterm"
config.default_prog = {
    "sh",
    "-c",
    "~/.config/wezterm/autostart.sh",
}
config.enable_wayland = false
config.color_scheme = "Gruvbox dark, hard (base16)"
config.font = wezterm.font("JetBrains Mono")
config.harfbuzz_features = { "zero", "cv12", "cv18" }
config.use_ime = true
config.window_decorations = "RESIZE"
config.enable_tab_bar = false
config.enable_scroll_bar = false
config.adjust_window_size_when_changing_font_size = false
config.default_cursor_style = "BlinkingBlock"
config.cursor_blink_ease_in = "EaseOut"
config.window_padding = {
    left = "0.25%",
    right = "0.10%",
    top = "0.5%",
    bottom = "0%",
}

-- And finally, return the configuration to wezterm
return config
