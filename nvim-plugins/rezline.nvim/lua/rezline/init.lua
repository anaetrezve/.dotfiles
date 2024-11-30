local M = {}

M.config = function(opts)
	opts = opts or {}
	local default_opts = {
		enabled = true,
	}

	-- Merge user options with defaults
	opts = vim.tbl_deep_extend("force", default_opts, opts or {})

	if opts.enabled then
		require("rezline.colors").set_default_Mode_highlight_colors()

		vim.o.statusline = "%!v:lua.require('rezline.statusline')()"

		require("rezline.utils").autocmds()
	end
end

M.setup = function(opts)
	M.config(opts)
end

return M
