local wezterm = require("wezterm")

local config = {}

if wezterm.config_builder then
    config = wezterm.config_builder()
end

-- Base Stylix configuration
local stylix_base_config = {
    color_scheme = "stylix",
    font = wezterm.font_with_fallback {
        "JetBrains Mono",
        "Noto Color Emoji",
    },
    font_size = 12,
    window_background_opacity = 0.75,
    window_frame = {
        active_titlebar_bg = "#7b8496",
        active_titlebar_fg = "#ffffff",
        active_titlebar_border_bottom = "#7b8496",
        border_left_color = "#1e2124",
        border_right_color = "#1e2124",
        border_bottom_color = "#1e2124",
        border_top_color = "#1e2124",
        button_bg = "#1e2124",
        button_fg = "#ffffff",
        button_hover_bg = "#ffffff",
        button_hover_fg = "#7b8496",
        inactive_titlebar_bg = "#1e2124",
        inactive_titlebar_fg = "#ffffff",
        inactive_titlebar_border_bottom = "#7b8496",
    },
    colors = {
        tab_bar = {
            background = "#1e2124",
            inactive_tab_edge = "#1e2124",
            active_tab = {
                bg_color = "#16181a",
                fg_color = "#ffffff",
            },
            inactive_tab = {
                bg_color = "#7b8496",
                fg_color = "#ffffff",
            },
            inactive_tab_hover = {
                bg_color = "#ffffff",
                fg_color = "#16181a",
            },
            new_tab = {
                bg_color = "#7b8496",
                fg_color = "#ffffff",
            },
            new_tab_hover = {
                bg_color = "#ffffff",
                fg_color = "#16181a",
            },
        },
    },
    command_palette_bg_color = "#1e2124",
    command_palette_fg_color = "#ffffff",
    command_palette_font_size = 10,
}

for key, value in pairs(stylix_base_config) do
    config[key] = value
end

config.max_fps = 144
config.animation_fps = 120
config.cursor_blink_rate = 250

config.enable_tab_bar = true
config.hide_tab_bar_if_only_one_tab = true
config.show_tab_index_in_tab_bar = false

config.visual_bell = {
    fade_in_duration_ms = 75,
    fade_out_duration_ms = 75,
    target = "CursorColor",
}

-- Key mappings
config.keys = {
    { key = "w", mods = "ALT",  action = wezterm.action.CloseCurrentTab({ confirm = true }) },
    { key = "t", mods = "ALT",  action = wezterm.action.SpawnTab("CurrentPaneDomain") },
}

config.exit_behavior = "CloseOnCleanExit"

return config
