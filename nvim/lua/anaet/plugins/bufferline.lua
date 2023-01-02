local status_ok, bufferline = pcall(require, "bufferline")

if not status_ok then
	return
end

bufferline.setup({

	options = {
		mode = "tabs", -- set to "tabs" to only show tabpages instead
		numbers = "none", --"none" | "ordinal" | "buffer_id" | "both" | function({ ordinal, id, lower, raise }): string,
		close_command = "bdelete! %d", -- can be a string | function, see "Mouse actions"
		right_mouse_command = "bdelete! %d", -- can be a string | function, see "Mouse actions"
		left_mouse_command = "buffer %d", -- can be a string | function, see "Mouse actions"
		middle_mouse_command = nil, -- can be a string | function, see "Mouse actions"
		indicator = {
			icon = "▎", -- this should be omitted if indicator style is not 'icon'
			style = "icon", -- 'icon' | 'underline' | 'none',
		},
		buffer_close_icon = "",
		modified_icon = "●",
		close_icon = "",
		left_trunc_marker = "",
		right_trunc_marker = "",
		--- name_formatter can be used to change the buffer's label in the bufferline.
		--- Please note some names can/will break the
		--- bufferline so use this at your discretion knowing that it has
		--- some limitations that will *NOT* be fixed.

		-- name_formatter = function(buf)  -- buf contains:
		-- name                | str        | the basename of the active file
		-- path                | str        | the full path of the active file
		-- bufnr (buffer only) | int        | the number of the active buffer
		-- buffers (tabs only) | table(int) | the numbers of the buffers in the tab
		-- tabnr (tabs only)   | int        | the "handle" of the tab, can be converted to its ordinal number using: `vim.api.nvim_tabpage_get_number(buf.tabnr)`
		-- end,
		--
		max_name_length = 18,
		max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
		truncate_names = true, -- whether or not tab names should be truncated
		tab_size = 18,
		diagnostics = "nvim_lsp", -- false | "nvim_lsp" | "coc",
		diagnostics_update_in_insert = false,
		-- The diagnostics indicator can be set to nil to keep the buffer name highlight but delete the highlighting
		-- diagnostics_indicator = function(count, level, diagnostics_dict, context)
		-- 	local icon = level:match("error") and " " or " "
		-- 	return " " .. icon .. count
		-- end,
		diagnostics_indicator = function(count, level, diagnostics_dict, context)
			local s = ""
			for e, n in pairs(diagnostics_dict) do
				local sym = e == "error" and "  " or (e == "warning" and "  " or "")
				s = s .. sym .. n
			end
			return s
		end,
		-- NOTE: this will be called a lot so don't do any heavy processing here

		-- custom_filter = function(buf_number, buf_numbers)
		-- 	-- filter out filetypes you don't want to see
		-- 	if vim.bo[buf_number].filetype ~= "<i-dont-want-to-see-this>" then
		-- 		return true
		-- 	end
		-- 	-- filter out by buffer name
		-- 	if vim.fn.bufname(buf_number) ~= "<buffer-name-I-dont-want>" then
		-- 		return true
		-- 	end
		-- 	-- filter out based on arbitrary rules
		-- 	-- e.g. filter out vim wiki buffer from tabline in your work repo
		-- 	if vim.fn.getcwd() == "<work-repo>" and vim.bo[buf_number].filetype ~= "wiki" then
		-- 		return true
		-- 	end
		-- 	-- filter out by it's index number in list (don't show first buffer)
		-- 	if buf_numbers[1] ~= buf_number then
		-- 		return true
		-- 	end
		-- end,

		offsets = {
			{
				filetype = "NvimTree",
				-- text = "File Explorer", -- "File Explorer" | function ,
				text = function()
					return vim.fn.getcwd()
				end,
				text_align = "left", -- "left" | "center" | "right"
				highlight = "directory",
				separator = true,
			},
		},
		color_icons = true, -- true | false, -- whether or not to add the filetype icon highlights
		show_buffer_icons = true, -- true | false, -- disable filetype icons for buffers
		show_buffer_close_icons = true, -- true | false,
		show_buffer_default_icon = false, -- true | false, -- whether or not an unrecognised filetype should show a default icon
		show_close_icon = false, -- true | false,
		show_tab_indicators = true, -- true | false,
		show_duplicate_prefix = true, -- true | false, -- whether to show duplicate buffer prefix
		persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
		-- can also be a table containing 2 custom separators
		-- [focused and unfocused]. eg: { '|', '|' }
		separator_style = "thick", -- "slant" | "thick" | "thin" | { 'any', 'any' },
		enforce_regular_tabs = false, -- false | true,
		always_show_bufferline = false, -- true | false,
		hover = {
			enabled = true,
			delay = 200,
			reveal = { "close" },
		},
		-- sort_by = 'insert_after_current' |'insert_at_end' | 'id' | 'extension' | 'relative_directory' | 'directory' | 'tabs' | function(buffer_a, buffer_b)
		--     -- add custom logic
		--     return buffer_a.modified > buffer_b.modified
		-- end
	},

	-- highlights = {
	-- 	fill = {
	-- 		fg = "<colour-value-here>",
	-- 		bg = "<colour-value-here>",
	-- 	},
	-- 	background = {
	-- 		fg = "<colour-value-here>",
	-- 		bg = "<colour-value-here>",
	-- 	},
	-- 	tab = {
	-- 		fg = "<colour-value-here>",
	-- 		bg = "<colour-value-here>",
	-- 	},
	-- 	tab_selected = {
	-- 		fg = "tabline_sel_bg",
	-- 		bg = "<colour-value-here>",
	-- 	},
	-- 	tab_close = {
	-- 		fg = "<colour-value-here>",
	-- 		bg = "<colour-value-here>",
	-- 	},
	-- 	close_button = {
	-- 		fg = "<colour-value-here>",
	-- 		bg = "<colour-value-here>",
	-- 	},
	-- 	close_button_visible = {
	-- 		fg = "<colour-value-here>",
	-- 		bg = "<colour-value-here>",
	-- 	},
	-- 	close_button_selected = {
	-- 		fg = "<colour-value-here>",
	-- 		bg = "<colour-value-here>",
	-- 	},
	-- 	buffer_visible = {
	-- 		fg = "<colour-value-here>",
	-- 		bg = "<colour-value-here>",
	-- 	},
	-- 	buffer_selected = {
	-- 		fg = "normal_fg",
	-- 		bg = "<colour-value-here>",
	-- 		bold = true,
	-- 		italic = true,
	-- 	},
	-- 	numbers = {
	-- 		fg = "<colour-value-here>",
	-- 		bg = "<colour-value-here>",
	-- 	},
	-- 	numbers_visible = {
	-- 		fg = "<colour-value-here>",
	-- 		bg = "<colour-value-here>",
	-- 	},
	-- 	numbers_selected = {
	-- 		fg = "<colour-value-here>",
	-- 		bg = "<colour-value-here>",
	-- 		bold = true,
	-- 		italic = true,
	-- 	},
	-- 	diagnostic = {
	-- 		fg = "<colour-value-here>",
	-- 		bg = "<colour-value-here>",
	-- 	},
	-- 	diagnostic_visible = {
	-- 		fg = "<colour-value-here>",
	-- 		bg = "<colour-value-here>",
	-- 	},
	-- 	diagnostic_selected = {
	-- 		fg = "<colour-value-here>",
	-- 		bg = "<colour-value-here>",
	-- 		bold = true,
	-- 		italic = true,
	-- 	},
	-- 	hint = {
	-- 		fg = "<colour-value-here>",
	-- 		sp = "<colour-value-here>",
	-- 		bg = "<colour-value-here>",
	-- 	},
	-- 	hint_visible = {
	-- 		fg = "<colour-value-here>",
	-- 		bg = "<colour-value-here>",
	-- 	},
	-- 	hint_selected = {
	-- 		fg = "<colour-value-here>",
	-- 		bg = "<colour-value-here>",
	-- 		sp = "<colour-value-here>",
	-- 		bold = true,
	-- 		italic = true,
	-- 	},
	-- 	hint_diagnostic = {
	-- 		fg = "<colour-value-here>",
	-- 		sp = "<colour-value-here>",
	-- 		bg = "<colour-value-here>",
	-- 	},
	-- 	hint_diagnostic_visible = {
	-- 		fg = "<colour-value-here>",
	-- 		bg = "<colour-value-here>",
	-- 	},
	-- 	hint_diagnostic_selected = {
	-- 		fg = "<colour-value-here>",
	-- 		bg = "<colour-value-here>",
	-- 		sp = "<colour-value-here>",
	-- 		bold = true,
	-- 		italic = true,
	-- 	},
	-- 	info = {
	-- 		fg = "<colour-value-here>",
	-- 		sp = "<colour-value-here>",
	-- 		bg = "<colour-value-here>",
	-- 	},
	-- 	info_visible = {
	-- 		fg = "<colour-value-here>",
	-- 		bg = "<colour-value-here>",
	-- 	},
	-- 	info_selected = {
	-- 		fg = "<colour-value-here>",
	-- 		bg = "<colour-value-here>",
	-- 		sp = "<colour-value-here>",
	-- 		bold = true,
	-- 		italic = true,
	-- 	},
	-- 	info_diagnostic = {
	-- 		fg = "<colour-value-here>",
	-- 		sp = "<colour-value-here>",
	-- 		bg = "<colour-value-here>",
	-- 	},
	-- 	info_diagnostic_visible = {
	-- 		fg = "<colour-value-here>",
	-- 		bg = "<colour-value-here>",
	-- 	},
	-- 	info_diagnostic_selected = {
	-- 		fg = "<colour-value-here>",
	-- 		bg = "<colour-value-here>",
	-- 		sp = "<colour-value-here>",
	-- 		bold = true,
	-- 		italic = true,
	-- 	},
	-- 	warning = {
	-- 		fg = "<colour-value-here>",
	-- 		sp = "<colour-value-here>",
	-- 		bg = "<colour-value-here>",
	-- 	},
	-- 	warning_visible = {
	-- 		fg = "<colour-value-here>",
	-- 		bg = "<colour-value-here>",
	-- 	},
	-- 	warning_selected = {
	-- 		fg = "<colour-value-here>",
	-- 		bg = "<colour-value-here>",
	-- 		sp = "<colour-value-here>",
	-- 		bold = true,
	-- 		italic = true,
	-- 	},
	-- 	warning_diagnostic = {
	-- 		fg = "<colour-value-here>",
	-- 		sp = "<colour-value-here>",
	-- 		bg = "<colour-value-here>",
	-- 	},
	-- 	warning_diagnostic_visible = {
	-- 		fg = "<colour-value-here>",
	-- 		bg = "<colour-value-here>",
	-- 	},
	-- 	warning_diagnostic_selected = {
	-- 		fg = "<colour-value-here>",
	-- 		bg = "<colour-value-here>",
	-- 		sp = "warning_diagnostic_fg",
	-- 		bold = true,
	-- 		italic = true,
	-- 	},
	-- 	error = {
	-- 		fg = "<colour-value-here>",
	-- 		bg = "<colour-value-here>",
	-- 		sp = "<colour-value-here>",
	-- 	},
	-- 	error_visible = {
	-- 		fg = "<colour-value-here>",
	-- 		bg = "<colour-value-here>",
	-- 	},
	-- 	error_selected = {
	-- 		fg = "<colour-value-here>",
	-- 		bg = "<colour-value-here>",
	-- 		sp = "<colour-value-here>",
	-- 		bold = true,
	-- 		italic = true,
	-- 	},
	-- 	error_diagnostic = {
	-- 		fg = "<colour-value-here>",
	-- 		bg = "<colour-value-here>",
	-- 		sp = "<colour-value-here>",
	-- 	},
	-- 	error_diagnostic_visible = {
	-- 		fg = "<colour-value-here>",
	-- 		bg = "<colour-value-here>",
	-- 	},
	-- 	error_diagnostic_selected = {
	-- 		fg = "<colour-value-here>",
	-- 		bg = "<colour-value-here>",
	-- 		sp = "<colour-value-here>",
	-- 		bold = true,
	-- 		italic = true,
	-- 	},
	-- 	modified = {
	-- 		fg = "<colour-value-here>",
	-- 		bg = "<colour-value-here>",
	-- 	},
	-- 	modified_visible = {
	-- 		fg = "<colour-value-here>",
	-- 		bg = "<colour-value-here>",
	-- 	},
	-- 	modified_selected = {
	-- 		fg = "<colour-value-here>",
	-- 		bg = "<colour-value-here>",
	-- 	},
	-- 	duplicate_selected = {
	-- 		fg = "<colour-value-here>",
	-- 		bg = "<colour-value-here>",
	-- 		italic = true,
	-- 	},
	-- 	duplicate_visible = {
	-- 		fg = "<colour-value-here>",
	-- 		bg = "<colour-value-here>",
	-- 		italic = true,
	-- 	},
	-- 	duplicate = {
	-- 		fg = "<colour-value-here>",
	-- 		bg = "<colour-value-here>",
	-- 		italic = true,
	-- 	},
	-- 	separator_selected = {
	-- 		fg = "<colour-value-here>",
	-- 		bg = "<colour-value-here>",
	-- 	},
	-- 	separator_visible = {
	-- 		fg = "<colour-value-here>",
	-- 		bg = "<colour-value-here>",
	-- 	},
	-- 	separator = {
	-- 		fg = "<colour-value-here>",
	-- 		bg = "<colour-value-here>",
	-- 	},
	-- 	indicator_selected = {
	-- 		fg = "<colour-value-here>",
	-- 		bg = "<colour-value-here>",
	-- 	},
	-- 	pick_selected = {
	-- 		fg = "<colour-value-here>",
	-- 		bg = "<colour-value-here>",
	-- 		bold = true,
	-- 		italic = true,
	-- 	},
	-- 	pick_visible = {
	-- 		fg = "<colour-value-here>",
	-- 		bg = "<colour-value-here>",
	-- 		bold = true,
	-- 		italic = true,
	-- 	},
	-- 	pick = {
	-- 		fg = "<colour-value-here>",
	-- 		bg = "<colour-value-here>",
	-- 		bold = true,
	-- 		italic = true,
	-- 	},
	-- 	offset_separator = {
	-- 		fg = "win_separator_fg",
	-- 		bg = "separator_background_color",
	-- 	},
	-- },
})
