-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local keymap = vim.keymap.set

-- Set highlight on search, but clear on pressing <Esc> in normal mode
keymap("n", "<ESC>", "<CMD>nohlsearch<CR>", { desc = "Clear search highlights" })

-- better indenting
keymap("n", "<", "<<", { desc = "Left indent" })
keymap("n", ">", ">>", { desc = "Right indent" })
keymap("v", "<", "<gv", { desc = "Left visual indent" })
keymap("v", ">", ">gv", { desc = "Right visual indent" })

