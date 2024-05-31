local wezterm = require("wezterm")

return {
	term = "xterm-256color",

	-- CURSOR
	cursor_blink_ease_in = "Constant",
	cursor_blink_ease_out = "Constant",
	cursor_blink_rate = 500,
	default_cursor_style = "BlinkingBlock",

	-- FONT
	font_size = 15,
	line_height = 1.4,
	font = wezterm.font({
		family = "CaskaydiaCove Nerd Font",
		harfbuzz_features = { "liga=1" },
	}),

	window_padding = {
		top = 0,
		left = 0,
		right = 0,
		bottom = 0,
	},

	keys = {
		{
			key = "m",
			mods = "CTRL",
			action = wezterm.action.ToggleFullScreen,
		},
	},
}
