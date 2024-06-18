require("nvchad.mappings")

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

-- better indenting
map("n", "<", "<<", { desc = "Left indent" })
map("n", ">", ">>", { desc = "Right indent" })
map("v", "<", "<gv", { desc = "Left visual indent" })
map("v", ">", ">gv", { desc = "Right visual indent" })

-- Not yanking with 'c' and 'x'
map({ "n", "v" }, "c", '"_c')
map("n", "C", '"_C')
map("n", "x", '"_x')

-- Move text up and down
map("x", "J", ":move '>+1<CR>gv-gv")
map("x", "K", ":move '<-2<CR>gv-gv")
map("x", "<A-j>", ":move '>+1<CR>gv-gv")
map("x", "<A-k>", ":move '<-2<CR>gv-gv")

-- Better up/down
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Move down", expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Move up", expr = true, silent = true })

-- Don't copy the replaced text after pasting in visual mode
-- https://vim.fandom.com/wiki/Replace_a_word_with_yanked_text#Alternative_mapping_for_paste
map({ "n", "x" }, "p", "P", { desc = "Dont copy replaced text" })
map("v", "p", '"_dP')
map("n", "dD", '"_dd')

-- Neo tree
map("n", "<leader>e", function()
  require("neo-tree.command").execute({ toggle = true, position = "left", dir = vim.uv.cwd() })
end, { desc = "Explorer NeoTree Filesystem (cwd)" })

-- Disable mappings
local nomap = vim.keymap.del

-- nomap("n", "<leader>e")
nomap("n", "<C-n>")
