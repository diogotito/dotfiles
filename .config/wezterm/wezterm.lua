local wezterm = require("wezterm")
local act = wezterm.action
local config = wezterm.config_builder()

-- Appearance
config.window_background_opacity = 0.95
config.text_background_opacity = 1.0 -- overlays over window_background_opacity, but makes some powerline-esque decorations look weird
config.color_scheme = "GruvboxDarkHard"

-- Appearance for Linux
if wezterm.target_triple == 'x86_64-unknown-linux-gnu' then
    -- Terminal font
    -- config.line_height = 0.95 -- Terminess is a bit taller than expected
    -- config.font = wezterm.font_with_fallback({ "Terminess Nerd Font", "Terminus" })
    config.font = wezterm.font({ family = "Iosevka Nerd Font" })

    -- UI tweaks
    config.ui_key_cap_rendering = "WindowsSymbols"

    -- Tab bar
    config.hide_tab_bar_if_only_one_tab = true
    config.use_fancy_tab_bar = false -- false for "retro mode""
    config.tab_max_width = 40 -- when using "retro mode", i.e. use_fancy_tab_bar = false

    -- Window frame for native (Fancy) Tab Bar appearance
    config.window_frame = {
        font = wezterm.font({ family = "Source Sans Pro" }),
        font_size = 10.0,
        active_titlebar_bg = "#272931",
        inactive_titlebar_bg = "#272931",
    }

    -- Tab stip colors
    config.colors = {
        tab_bar = {
            background = "#272931",
            inactive_tab_edge = "#4D586E",
            active_tab = {
                bg_color = "#4D586E",
                fg_color = "#D3DAE3",
            },
            inactive_tab = {
                bg_color = "#272931",
                fg_color = "#888888",
            },
        },
    }

-- Appearance for Windows
elseif wezterm.target_triple == 'x86_64-pc-windows-msvc' then
    -- Window
    config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"
    config.use_resize_increments = true
    config.use_fancy_tab_bar = true
    config.window_frame = {
        active_titlebar_bg = "#282f38",
        inactive_titlebar_bg = "#282f38"
    }
    config.colors = {
        tab_bar = {
            active_tab = {
                bg_color = "#1e1f20",
                fg_color = "#D3DAE3",
            },
        },
    }
    -- config.win32_system_backdrop = 'Acrylic' -- heavy af

    -- Text
    config.font = wezterm.font_with_fallback({ "Consolas", "MesloLGS NF Regular" })
    config.font_size = 11.0
    config.line_height = 1.0
    config.window_frame.font = wezterm.font 'Segoe UI'
    config.window_frame.font_size = 10
end

-- Terminal keys
config.enable_kitty_keyboard = true

-- Keybindings
config.keys = {
	{
		key = "k",
		mods = "CTRL|SHIFT",
		action = act.DisableDefaultAssignment,
	},
	{
		key = "P",
		mods = "CTRL|SHIFT|ALT",
		action = act.ShowLauncher,
	},
}

-- Mouse bindings
config.mouse_bindings = {
	-- Wezterm pastes with MMB by default, but I'm used to pasting with RMB
	{
		event = { Down = { streak = 1, button = "Right" } },
		mods = "NONE",
		action = act.PasteFrom("Clipboard"),
	},
}

return config
