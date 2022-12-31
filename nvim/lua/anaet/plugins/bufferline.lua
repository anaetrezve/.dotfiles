local bufferline_status, bufferline = pcall(require, "bufferline")

if not bufferline_status then
	return
end

bufferline.setup({
	options = {
		diagnostics = "nvim_lsp",
		color_icons = true,
		show_buffer_icons = true, -- disable filetype icons for buffers
		show_buffer_close_icons = true,
		show_buffer_default_icon = true, -- whether or not an unrecognised filetype should show a default icon
		show_close_icon = true,
		show_tab_indicators = true,
		offsets = {
			{
				filetype = "NvimTree",
				text = "File Explorer",
				text_align = "center",
				separator = true,
			},
		},
		always_show_bufferline = true,
		hover = {
			enabled = true,
			delay = 200,
			reveal = { "close" },
		},
		diagnostics_indicator = function(count, level, diagnostics_dict, context)
			local icon = level:match("error") and " " or " "
			return " " .. icon .. count
		end,
	},
})
