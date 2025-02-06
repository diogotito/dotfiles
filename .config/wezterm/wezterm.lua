local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- Terminal font
config.line_height = 0.95 -- Terminess is a bit taller than expected
config.font = wezterm.font_with_fallback({ "Terminess Nerd Font", "Terminus" })

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

-- Colors
config.window_background_opacity = 0.95
config.text_background_opacity = 1.0 -- overlays over window_background_opacity, but makes some powerline-esque decorations look weird

config.color_scheme = "Batman"

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

-- Terminal keys
config.enable_kitty_keyboard = true

-- Keybindings
config.keys = {
	-- Turn off the default CMD-m Hide action, allowing CMD-m to
	-- be potentially recognized and handled by the tab
	{
		key = "k",
		mods = "CTRL|SHIFT",
		action = wezterm.action.DisableDefaultAssignment,
	},
}

return config
