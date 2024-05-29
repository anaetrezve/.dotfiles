local wezterm = require("wezterm")

return {
	color_scheme = "Catppuccin Mocha",

	font = wezterm.font({
		family = "JetBrains Mono",
	}),

	font_size = 16,
	enable_tab_bar = false,
	line_height = 1.3,
	window_decorations = "RESIZE",
	window_padding = {
		bottom = 0,
		top = 0,
		left = 0,
		right = 0,
	},

	keys = {
		{
			key = "m",
			mods = "CTRL",
			action = wezterm.action.ToggleFullScreen,
		},
	},
}
