local keymap = vim.keymap.set
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
