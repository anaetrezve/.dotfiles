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
-- Save with mac command key
keymap({ "i", "n" }, "<D-s>", "<CMD> w <CR>", { desc = "Save file" })

keymap("n", "<C-a>", "ggVG", { desc = "Select All" })
keymap("n", "<D-a>", "ggVG", { desc = "Select All" })

-- Not yanking with 'c' and 'x'
keymap({ "n", "v" }, "c", '"_c')
keymap("n", "C", '"_C')
keymap("n", "x", '"_x')

-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", { desc = "Move selected lines down" })
keymap("x", "K", ":move '<-2<CR>gv-gv", { desc = "Move selected lines up" })
-- keymap({ "x", "n" }, "<M-j>", ":move '>+1<CR>gv-gv")
-- keymap({ "x", "n" }, "<M-k>", ":move '<-2<CR>gv-gv")
-- keymap("v", "<M-k>", ":m .-2<CR>==")
-- keymap("v", "<M-j>", ":m .+1<CR>==")

keymap("n", "J", "mzJ`z")
keymap("n", "n", "nzzzv")
keymap("n", "N", "Nzzzv")
-- keymap("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
keymap("n", ";", ":")

-- increment/decrement numbers
-- keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" }) -- increment
-- keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" }) -- decrement

-- window management
keymap("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
keymap("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })
keymap("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" })
keymap("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" })
keymap("n", "<leader>.", "5<C-w>>", { desc = "Increase split size to right" })
keymap("n", "<leader>,", "5<C-w><", { desc = "Increase split size to left" })

-- diagnostics
keymap(
  "n",
  "<leader>d",
  ':lua vim.diagnostic.open_float(nil, {scope="cursor"})<CR>',
  { desc = "Open floating window for the diagnostic" }
)

-- keymap("n", "<ESC>", function()
--   for _, win in ipairs(vim.api.nvim_list_wins()) do
--     if vim.api.nvim_win_get_config(win).relative == "win" then
--       vim.api.nvim_win_close(win, false)
--     end
--   end
-- end)

-- keymap("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" }) -- open new tab
-- keymap("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" }) -- close current tab
-- keymap("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" }) --  go to next tab
-- keymap("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" }) --  go to previous tab
-- keymap("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab

-- Barbar keymaps --

-- Close buffer
keymap("n", "<leader>tx", "<Cmd>bd<CR>", { desc = "Close current buffer" })
keymap("n", "<leader>tn", function()
  if vim.fn.tabpagenr("$") > 1 then
    vim.cmd("tabnext")
  else
    vim.cmd("bnext")
  end
end, { desc = "Go to next tab or buffer" }) --  go to next tab
keymap("n", "<leader>tp", function()
  if vim.fn.tabpagenr("$") > 1 then
    vim.cmd("tabprev")
  else
    vim.cmd("bprev")
  end
end, { desc = "Go to previous tab or buffer" }) --  go to previous tab
-- Move to previous/next
keymap("n", "<Tab>", function()
  if vim.fn.tabpagenr("$") > 1 then
    vim.cmd("tabnext")
  else
    vim.cmd("bnext")
  end
end, { desc = "Go to next tab or buffer" })

keymap("n", "<S-Tab>", function()
  if vim.fn.tabpagenr("$") > 1 then
    vim.cmd("tabprev")
  else
    vim.cmd("bprev")
  end
end, { desc = "Go to previous tab or buffer" })
-- Goto buffer in position...
keymap("n", "<C-1>", "<Cmd>BufferLineGoToBuffer 1<CR>", { desc = "Goto buffer 1" })
keymap("n", "<C-2>", "<Cmd>BufferLineGoToBuffer 2<CR>", { desc = "Goto buffer 2" })
keymap("n", "<C-3>", "<Cmd>BufferLineGoToBuffer 3<CR>", { desc = "Goto buffer 3" })
keymap("n", "<C-4>", "<Cmd>BufferLineGoToBuffer 4<CR>", { desc = "Goto buffer 4" })
keymap("n", "<C-5>", "<Cmd>BufferLineGoToBuffer 5<CR>", { desc = "Goto buffer 5" })
keymap("n", "<C-6>", "<Cmd>BufferLineGoToBuffer 6<CR>", { desc = "Goto buffer 6" })
keymap("n", "<C-7>", "<Cmd>BufferLineGoToBuffer 7<CR>", { desc = "Goto buffer 7" })
keymap("n", "<C-8>", "<Cmd>BufferLineGoToBuffer 8<CR>", { desc = "Goto buffer 8" })
keymap("n", "<C-9>", "<Cmd>BufferLineGoToBuffer 9<CR>", { desc = "Goto buffer 9" })
keymap("n", "<C-0>", "<Cmd>BufferLineGoToBuffer -1<CR>", { desc = "Goto buffer last" })
-- Re-order to left/right
keymap("n", "<C-,>", "<Cmd>BufferLineMovePrev<CR>", { desc = "Move current buffer to left" })
keymap("n", "<C-.>", "<Cmd>BufferLineMoveNext<CR>", { desc = "Move current buffer to right" })
