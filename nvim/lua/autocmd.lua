-- highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.api.nvim_create_autocmd({ "BufEnter" }, {
  callback = function()
    vim.opt.formatoptions:remove({ "o", "r", "c" })
    vim.opt.formatoptions:append({ "t" })
  end,
})
