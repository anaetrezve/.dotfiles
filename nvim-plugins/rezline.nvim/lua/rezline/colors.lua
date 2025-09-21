-- Catppuccin Mocha colors palettes
-- rosewater = "#f5e0dc",
-- flamingo = "#f2cdcd",
-- pink = "#f5c2e7",
-- mauve = "#cba6f7",
-- red = "#f38ba8",
-- maroon = "#eba0ac",
-- peach = "#fab387",
-- yellow = "#f9e2af",
-- green = "#a6e3a1",
-- teal = "#94e2d5",
-- sky = "#89dceb",
-- sapphire = "#74c7ec",
-- blue = "#89b4fa",
-- lavender = "#b4befe",
-- text = "#cdd6f4",
-- subtext1 = "#bac2de",
-- subtext0 = "#a6adc8",
-- overlay2 = "#9399b2",
-- overlay1 = "#7f849c",
-- overlay0 = "#6c7086",
-- surface2 = "#585b70",
-- surface1 = "#45475a",
-- surface0 = "#313244",
-- base = "#1e1e2e",
-- mantle = "#181825",
-- crust = "#11111b",
local M = {}

M.colors = {
	Normal = "guifg=#74c7ec guibg=#313244",
	Insert = "guifg=#a6e3a1 guibg=#313244",
	Visual = "guifg=#89b4fa guibg=#313244",
	Replace = "guifg=#f9e2af guibg=#313244",
	Command = "guifg=#fab387 guibg=#313244",
}

M.diagnostic_colors = function()
	vim.cmd("highlight " .. "St_lspError" .. " guifg=#f38ba8 guibg=#181825")
	vim.cmd("highlight " .. "St_lspInfo" .. " guifg=#89b4fa guibg=#181825")
	vim.cmd("highlight " .. "St_lspWarning" .. " guifg=#fab387 guibg=#181825")
	vim.cmd("highlight " .. "St_lspHints" .. " guifg=#89dceb guibg=#181825")
end

M.mode_colors = function()
	for mode, color in pairs(M.colors) do
		vim.cmd("highlight " .. "St_" .. mode .. "_Mode" .. " " .. color)
	end
end

M.git_colors = function()
	vim.cmd("highlight " .. "St_git_added" .. " guifg=#a6e3a1 guibg=#181825")
	vim.cmd("highlight " .. "St_git_modified" .. " guifg=#f9e2af guibg=#181825")
	vim.cmd("highlight " .. "St_git_deleted" .. " guifg=#f38ba8 guibg=#181825")
	vim.cmd("highlight " .. "St_git_branch" .. " guifg=#cdd6f4 guibg=#181825")
end

M.lsp_loaders = function()
	vim.cmd("highlight " .. "St_lsp_loader" .. " guifg=#89b4fa guibg=#181825")
	vim.cmd("highlight " .. "St_lsp_loading_done" .. " guifg=#a6e3a1 guibg=#181825")
end

M.snacks_status_colors = function()
	vim.cmd("highlight " .. "St_snacks_picker_title" .. " guifg=#74c7ec guibg=#313244")
	vim.cmd("highlight " .. "St_snacks_meta" .. " guifg=#a6e3a1 guibg=#181825")
end

M.set_default_Mode_highlight_colors = function()
	M.mode_colors()
	M.diagnostic_colors()
	M.git_colors()
	M.lsp_loaders()
	M.snacks_status_colors()
end

return M
