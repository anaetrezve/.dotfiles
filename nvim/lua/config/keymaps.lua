local keymap = vim.keymap.set
-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Keymap for opening file explorer (Neo Tree or native)
keymap("n", "<leader>e", function()
  local has_neo_tree, _ = pcall(require, "neo-tree")
  if has_neo_tree then
    vim.cmd("Neotree toggle")
  else
    vim.cmd("Explore")
  end
end, { desc = "Toggle File Explorer (Neo Tree/Native)" })
