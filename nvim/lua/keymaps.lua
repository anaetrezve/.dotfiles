-- mode
--  "n" - normal mode
--  "i" - insert mode
--  "x" - visual mode
--  "v" - visual and select mode

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

-- -- better move
-- keymap("n", "j", "gj", { desc = "Move down" })
-- keymap("n", "k", "gk", { desc = "Move up" })

-- Better up/down
keymap({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Move down", expr = true, silent = true })
keymap({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Move up", expr = true, silent = true })

-- Don't copy the replaced text after pasting in visual mode
-- https://vim.fandom.com/wiki/Replace_a_word_with_yanked_text#Alternative_mapping_for_paste
-- keymap({ "n", "x" }, "p", "P", { desc = "Dont copy replaced text" })
keymap("v", "p", '"_dP')
-- keymap("x", "p", "P")
keymap("n", "dD", '"_dd')

keymap({ "i", "n" }, "<C-s>", "<CMD> w <CR>", { desc = "Save file" })

keymap("n", "<c-a>", "ggVG", { desc = "Select All" })

-- Not yanking with 'c' and 'x'
keymap({ "n", "v" }, "c", '"_c')
keymap("n", "C", '"_C')
keymap("n", "x", '"_x')

-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv")
keymap("x", "K", ":move '<-2<CR>gv-gv")
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv")
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv")

-- Move text up and down
keymap("v", "<A-j>", ":m .+1<CR>==")
keymap("v", "<A-k>", ":m .-2<CR>==")
keymap("n", "J", "mzJ`z")
keymap("n", "n", "nzzzv")
keymap("n", "N", "Nzzzv")
-- keymap("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
keymap("n", ";", ":")

-- increment/decrement numbers
-- keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" }) -- increment
-- keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" }) -- decrement

-- window management
keymap("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
keymap("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
keymap("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
keymap("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window

keymap("n", "<ESC>", function()
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    if vim.api.nvim_win_get_config(win).relative == "win" then
      vim.api.nvim_win_close(win, false)
    end
  end
end)

-- Set the keymap
keymap("n", "<leader>tn", function()
  if vim.fn.tabpagenr("$") > 1 then
    vim.cmd("tabnext")
  else
    vim.cmd("bnext")
  end
end, { desc = "Go to next tab or buffer" })

keymap("n", "<leader>tp", function()
  if vim.fn.tabpagenr("$") > 1 then
    vim.cmd("tabprev")
  else
    vim.cmd("bprev")
  end
end, { desc = "Go to previous tab or buffer" })

-- keymap("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" }) -- open new tab
-- keymap("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" }) -- close current tab
-- keymap("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" }) --  go to next tab
-- keymap("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" }) --  go to previous tab
-- keymap("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab
