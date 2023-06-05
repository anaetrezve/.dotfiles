-- import nvim-tree plugin safely
local setup, nvimtree = pcall(require, "nvim-tree")
if not setup then
	return
end

-- recommended settings from nvim-tree documentation
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- change color for arrows in tree to light blue
vim.cmd([[ highlight NvimTreeIndentMarker guifg=#3FC5FF ]])

-- local list = {
-- 	{ key = "nt", action = "tabnew" },
-- }

-- kaymapping
local function my_on_attach(bufnr)
	local api = require("nvim-tree.api")

	api.config.mappings.default_on_attach(bufnr)

	vim.keymap.set("n", "nt", api.node.open.tab, { buffer = bufnr })
end

-- local tree_options = {
-- 	filters = {
-- 		dotfiles = false,
-- 	},
-- 	disable_netrw = true,
-- 	hijack_netrw = true,
-- 	hijack_cursor = true,
-- 	hijack_unnamed_buffer_when_opening = false,
-- 	sync_root_with_cwd = true,
-- 	update_focused_file = {
-- 		enable = true,
-- 		update_root = false,
-- 	},
-- 	view = {
-- 		adaptive_size = false,
-- 		side = "left",
-- 		width = 30,
-- 		preserve_window_proportions = true,
-- 	},
-- 	git = {
-- 		enable = false,
-- 		ignore = true,
-- 	},
-- 	filesystem_watchers = {
-- 		enable = true,
-- 	},
-- 	actions = {
-- 		open_file = {
-- 			resize_window = true,
-- 		},
-- 	},
-- 	renderer = {
-- 		root_folder_label = false,
-- 		highlight_git = false,
-- 		highlight_opened_files = "none",
--
-- 		indent_markers = {
-- 			enable = false,
-- 		},
--
-- 		icons = {
-- 			show = {
-- 				file = true,
-- 				folder = true,
-- 				folder_arrow = true,
-- 				git = false,
-- 			},
--
-- 			glyphs = {
-- 				default = "󰈚",
-- 				symlink = "",
-- 				folder = {
-- 					default = "",
-- 					empty = "",
-- 					empty_open = "",
-- 					open = "",
-- 					symlink = "",
-- 					symlink_open = "",
-- 					arrow_open = "",
-- 					arrow_closed = "",
-- 				},
-- 				git = {
-- 					unstaged = "✗",
-- 					staged = "✓",
-- 					unmerged = "",
-- 					renamed = "➜",
-- 					untracked = "★",
-- 					deleted = "",
-- 					ignored = "◌",
-- 				},
-- 			},
-- 		},
-- 	},
-- }

local tree_options = {
	view = {
		preserve_window_proportions = true,
		-- mappings = {
		-- 	custom_only = false,
		-- 	list = list,
		-- },
	},
	-- change folder arrow icons
	renderer = {
		root_folder_label = false,
		icons = {
			glyphs = {
				folder = {
					arrow_open = "",
					arrow_closed = "",
				},
				git = {
					unstaged = "✗",
					staged = "✓",
					unmerged = "",
					renamed = "➜",
					untracked = "★",
					deleted = "",
					ignored = "◌",
				},
			},
		},
	},
	-- disable window_picker for
	-- explorer to work well with
	-- window splits
	actions = {
		open_file = {
			window_picker = {
				enable = false,
			},
		},
	},
	-- 	git = {
	-- 		ignore = false,
	-- 	},
	filters = {
		custom = {
			"^.git$",
		},
	},
	on_attach = my_on_attach,
}

-- configure nvim-tree
nvimtree.setup(tree_options)

-- open nvim-tree on setup

local function open_nvim_tree(data)
	-- buffer is a [No Name]
	local no_name = data.file == "" and vim.bo[data.buf].buftype == ""

	-- buffer is a directory
	local directory = vim.fn.isdirectory(data.file) == 1

	if not no_name and not directory then
		return
	end

	-- change to the directory
	if directory then
		vim.cmd.cd(data.file)
	end

	-- open the tree
	require("nvim-tree.api").tree.open()
end

vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })
