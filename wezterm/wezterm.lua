local wezterm = require("wezterm")

local function scheme_for_appearance(appearance)
	if appearance:find("Dark") then
		return "Catppuccin Mocha"
	else
		return "Catppuccin Latte"
	end
end

return {
	term = "xterm-256color",

	-- color_scheme = "Catppuccin Mocha", -- or Macchiato, Frappe, Latte
	color_scheme = scheme_for_appearance(wezterm.gui.get_appearance()),

	-- CURSOR
	cursor_blink_ease_in = "Constant",
	cursor_blink_ease_out = "Constant",
	cursor_blink_rate = 500,
	default_cursor_style = "BlinkingBlock",

	-- FONT
	font_size = 15,
	line_height = 1.4,
	font = wezterm.font({
		family = "JetBrains Mono",
		harfbuzz_features = { "liga=1" },
	}),

	window_padding = {
		top = 8,
		left = 0,
		right = 0,
		bottom = 0,
	},

	native_macos_fullscreen_mode = false,
	window_decorations = "RESIZE",
	enable_tab_bar = false,

	keys = {
		{
			key = "m",
			mods = "CTRL",
			action = wezterm.action.ToggleFullScreen,
		},
	},
}
