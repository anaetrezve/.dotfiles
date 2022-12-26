-- import nvim-autopairs safely
local catppuccin_setup, catppuccin = pcall(require, "catppuccin")
if not catppuccin_setup then
	return
end

catppuccin.setup({
	flavour = "macchiato",
	-- color_overrides = {
	-- 	mocha = {
	-- 		base = "#000000",
	-- 	},
	-- },
	integrations = {
		nvimtree = true,
	},
	-- highlight_overrides = {
	-- 	mocha = function(mocha)
	-- 		return {
	-- 			NvimTreeNormal = { bg = mocha.none },
	-- 		}
	-- 	end,
	-- },
})
