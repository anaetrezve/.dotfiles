local wezterm = require("wezterm")
local ok, local_config = pcall(require, "local-config")

local action = wezterm.action

if not ok then
	local_config = {}
end

local function spread(...)
	local result = {}

	for _, t in ipairs({ ... }) do
		for k, v in pairs(t) do
			result[k] = v
		end
	end

	return result
end

local function scheme_for_appearance(appearance)
	if appearance:find("Dark") then
		return "Catppuccin Mocha"
	else
		return "Catppuccin Latte"
	end
end

return spread({
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
	line_height = 1.5,
	font = wezterm.font("JetBrains Mono", {
		weight = "Bold",
	}),

	window_padding = {
		top = 0,
		left = 0,
		right = 0,
		bottom = 0,
	},

	native_macos_fullscreen_mode = true,
	window_decorations = "TITLE | RESIZE",
	enable_tab_bar = false,

	initial_cols = 200,
	initial_rows = 100,

	enable_kitty_keyboard = true,
	enable_csi_u_key_encoding = false,

	keys = {
		{
			key = "m",
			mods = "CTRL",
			action = action.ToggleFullScreen,
		},
		{
			key = "k",
			mods = "SUPER",
			action = action.Multiple({
				action.ClearScrollback("ScrollbackAndViewport"),
				action.SendKey({ key = "L", mods = "CTRL" }),
			}),
		},
	},
}, local_config)
