-- HIGHLIGHT ON YANK
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank({ timeout = 200 }) -- Highlight yanked text for 200ms
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

-- OPEN HELP IN NEW BUFFER OR TAB
vim.api.nvim_create_autocmd("FileType", {
  pattern = "help",
  command = ":wincmd L | vertical resize 80", -- Moves help to the right and resizes it
  -- command = ":wincmd T", -- Moves help to a new tab
})

-- === Additional Useful Autocmds for Better Developer Experience ===

-- Automatically trim trailing whitespace on save
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  command = "%s/\\s\\+$//e", -- Remove trailing whitespace
})

-- Automatically reload the file if it changes outside of Neovim
vim.api.nvim_create_autocmd("FileChangedShellPost", {
  pattern = "*",
  command = "echohl WarningMsg | echo 'File changed on disk. Reloaded.' | echohl None",
})

-- Show cursor line only in the active window
vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
  callback = function()
    vim.wo.cursorline = true
  end,
})
vim.api.nvim_create_autocmd({ "WinLeave", "BufLeave" }, {
  callback = function()
    vim.wo.cursorline = false
  end,
})

-- Automatically close certain filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "help", "qf", "man", "lspinfo", "startuptime", "checkhealth" },
  command = "nnoremap <buffer> <silent> q :close<CR>",
})

-- Enable spell checking for certain filetypes
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown", "text", "gitcommit" },
  callback = function()
    vim.opt_local.spell = true
    vim.opt_local.spelllang = { "en_us" }
  end,
})

-- Automatically create missing directories when saving a file
vim.api.nvim_create_autocmd("BufWritePre", {
  callback = function()
    local dir = vim.fn.expand("<afile>:p:h")
    if vim.fn.isdirectory(dir) == 0 then
      vim.fn.mkdir(dir, "p")
    end
  end,
})

-- Automatically set normal number in insert mode
vim.api.nvim_create_autocmd(
  { "BufEnter", "FocusGained", "InsertLeave", "WinEnter" },
  { pattern = "*", command = "if &nu && mode() != 'i' | set rnu | endif" }
)
-- Automatically set relative number in normal mode
vim.api.nvim_create_autocmd(
  { "BufLeave", "FocusLost", "InsertEnter", "WinLeave" },
  { pattern = "*", command = "if &nu | set nornu | endif" }
)

-- Auto-resize splits when window is resized
vim.api.nvim_create_autocmd("VimResized", {
  callback = function()
    vim.cmd("tabdo wincmd =")
  end,
})

-- -- Hide the status line in command mode
-- vim.api.nvim_create_autocmd("CmdlineEnter", {
--   callback = function()
--     vim.opt.laststatus = 0
--   end,
-- })
-- -- Show the status line when leaving command mode
-- vim.api.nvim_create_autocmd("CmdlineLeave", {
--   callback = function()
--     vim.opt.laststatus = 2
--   end,
-- })

vim.api.nvim_create_user_command("LspInfo", function()
  local clients = vim.lsp.get_clients({ bufnr = 0 })
  if #clients == 0 then
    print("No LSP clients attached to current buffer")
  else
    for _, client in ipairs(clients) do
      print("LSP: " .. client.name .. " (ID: " .. client.id .. ")")
    end
  end
end, { desc = "Show LSP client info" })

-- Disable relative numbers and conceal level in Copilot buffers
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "copilot-chat",
  callback = function()
    vim.opt_local.relativenumber = false
    vim.opt_local.number = false
    vim.opt_local.conceallevel = 0
  end,
})
