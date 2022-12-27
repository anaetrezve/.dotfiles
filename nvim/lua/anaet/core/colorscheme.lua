-- set colorscheme to nightfly with protected call
-- in case it isn't installed
local status, _ = pcall(vim.cmd, "colorscheme nightfly")
if not status then
	print("Colorscheme not found!") -- print error if colorscheme not installed
	return
end

-- local colorbuddy_status, colorbuddy = pcall(require, "colorbuddy")
-- if not colorbuddy_status then
-- 	return
-- end
--
-- colorbuddy.colorscheme("cobalt2")
