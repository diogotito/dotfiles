-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices
config.color_scheme = "Batman"
config.font = wezterm.font_with_fallback({ "Terminess Nerd Font", "Terminus" })
config.hide_tab_bar_if_only_one_tab = true

config.keys = {
	-- Turn off the default CMD-m Hide action, allowing CMD-m to
	-- be potentially recognized and handled by the tab
	{
		key = "k",
		mods = "CTRL|SHIFT",
		action = wezterm.action.DisableDefaultAssignment,
	},
}

-- and finally, return the configuration to wezterm
return config
