--- Wrapper for vim.keymap.set with type annotations.
--- @param mode string|string[]
--- @param lhs string
--- @param rhs string|function
--- @param opts table|nil
local function keymap(mode, lhs, rhs, opts)
  local default_opts = { noremap = true, silent = true }
  opts = vim.tbl_extend("force", default_opts, opts or {})
  vim.keymap.set(mode, lhs, rhs, opts)
end

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Keymap for opening file explorer (Neo Tree or native)
keymap("n", "<leader>e", function()
  -- local has_neo_tree, _ = pcall(require, "neo-tree")
  -- vim.cmd("Neotree toggle")
  local has_oil, _ = pcall(require, "oil")
  -- local has_snacks, _ = pcall(require, "snacks")
  if has_oil then
    vim.cmd("Oil")
  -- elseif has_snacks then
  --   vim.cmd("lua Snacks.picker.explorer()")
  else
    vim.cmd("Explore")
  end
end, { desc = "Toggle File Explorer (Neo Tree/Native)" })

keymap("n", "<Esc>", function()
  -- Clear search highlights
  vim.schedule(function()
    vim.cmd("nohlsearch")
  end)

  -- Close all popup windows
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local win_config = vim.api.nvim_win_get_config(win)
    -- do not close if col 0 assuming Snacks explorer is starting from col 0
    if win_config.relative ~= "" and win_config.col ~= 0 then
      vim.api.nvim_win_close(win, true)
    end
  end
end, { desc = "Close popup window & clear search highlights" })

-- Better indenting
keymap("n", "<", "<<", { desc = "Left indent" })
keymap("n", ">", ">>", { desc = "Right indent" })
keymap("v", "<", "<gv", { desc = "Left visual indent" })
keymap("v", ">", ">gv", { desc = "Right visual indent" })

-- Better J behavior
keymap("n", "J", "mzJ`z", { desc = "Join lines and keep cursor position" })
keymap({ "n", "x" }, "j", "gj", { desc = "Move down" })
keymap({ "n", "x" }, "k", "gk", { desc = "Move up" })

-- Don't copy the replaced text after pasting in visual mode
-- https://vim.fandom.com/wiki/Replace_a_word_with_yanked_text#Alternative_mapping_for_paste
-- keymap({ "n", "x" }, "p", "P", { desc = "Dont copy replaced text" })
keymap("v", "p", '"_dP')
-- keymap("n", "dD", '"_dd')

-- Save file
keymap({ "i", "n" }, "<C-s>", "<CMD> w <CR>", { desc = "Save file" })
keymap({ "i", "n" }, "<D-s>", "<CMD> w <CR>", { desc = "Save file" })

-- Select all
keymap("n", "<C-a>", "ggVG", { desc = "Select all in current buffer" })
keymap("n", "<D-a>", "ggVG", { desc = "Select all in current buffer" }) -- not work with ghostty

-- Not yanking with 'c' and 'x'
-- keymap({ "n", "v" }, "c", '"_c')
keymap("n", "C", '"_C')
keymap("n", "x", '"_x')

-- Center screen when jumping
keymap("n", "n", "nzzzv", { desc = "Next search result (centered)" })
keymap("n", "N", "Nzzzv", { desc = "Previous search result (centered)" })
keymap("n", "<C-d>", "<C-d>zz", { desc = "Half page down (centered)" })
keymap("n", "<C-u>", "<C-u>zz", { desc = "Half page up (centered)" })

-- Delete without yanking
-- keymap({ "n", "v" }, "d", '"_d', { desc = "Delete without yanking" })

-- Splitting & Resizing
keymap("n", "<leader>sv", ":vsplit<CR>", { desc = "Split window vertically" })
keymap("n", "<leader>sh", ":split<CR>", { desc = "Split window horizontally" })
keymap("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" })
keymap("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" })
keymap("n", "<C-Up>", ":resize +2<CR>", { desc = "Increase window height" })
keymap("n", "<C-Down>", ":resize -2<CR>", { desc = "Decrease window height" })
keymap("n", "<C-Left>", ":vertical resize -2<CR>", { desc = "Decrease window width" })
keymap("n", "<C-Right>", ":vertical resize +2<CR>", { desc = "Increase window width" })

-- Move lines up/down (M is option key in mac)
keymap("n", "<M-j>", ":move .+1<CR>==", { desc = "Move line down" })
keymap("n", "<M-k>", ":move .-2<CR>==", { desc = "Move line up" })
keymap("v", "<M-j>", ":move '>+1<CR>gv=gv", { desc = "Move selection down" })
keymap("v", "<M-k>", ":move '<-2<CR>gv=gv", { desc = "Move selection up" })
keymap("x", "J", ":move '>+1<CR>gv-gv", { desc = "Move selected lines down" })
keymap("x", "K", ":move '<-2<CR>gv-gv", { desc = "Move selected lines up" })
