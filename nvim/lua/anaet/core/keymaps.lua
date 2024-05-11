-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local keymap = vim.keymap

-- Set highlight on search, but clear on pressing <Esc> in normal mode
keymap.set("n", "<ESC>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlights" })
