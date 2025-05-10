-- HIGHLIGHT ON YANK
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank({
      timeout = 100,
    })
  end,
})

-- PREVENT COMMENT CONTINUETION TO NEXT LINE
vim.api.nvim_create_autocmd({ "BufEnter" }, {
  callback = function()
    vim.opt.formatoptions:remove({ "o", "r", "c" })
    vim.opt.formatoptions:append({ "t" })
  end,
})

-- JUMP TO LAST EDIT POSITION ON OPENING FILE
vim.api.nvim_create_autocmd("BufReadPost", {
  desc = "Open file at the last position it was edited earlier",
  pattern = "*",
  command = 'silent! normal! g`"zv',
})

-- OPEN HELP IN NEW TAB
vim.api.nvim_create_autocmd("FileType", {
  pattern = "help",
  command = ":wincmd T",
})
