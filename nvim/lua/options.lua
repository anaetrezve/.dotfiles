vim.cmd("let g:netrw_liststyle = 3")

local opt = vim.opt -- for conciseness

-- line numbers
opt.relativenumber = true -- show relative line numbers
opt.number = true -- shows absolute line number on cursor line (when relative number is on)
opt.numberwidth = 2
opt.ruler = false

-- tabs & indentation
opt.tabstop = 2 -- 2 spaces for tabs (prettier default)
opt.shiftwidth = 2 -- 2 spaces for indent width
opt.expandtab = true -- expand tab to spaces
opt.autoindent = true -- copy indent from current line when starting new one
opt.softtabstop = 2

-- line wrapping
-- opt.wrap = true -- disable line wrapping

-- search settings
opt.ignorecase = true -- ignore case when searching
opt.smartcase = true -- if you include mixed case in your search, assumes you want case-sensitive

-- cursor line
opt.cursorline = true -- highlight the current cursor line
-- opt.cursorlineopt = "number"

-- appearance

-- turn on termguicolors for nightfly colorscheme to work
-- (have to use iterm2 or any other true color terminal)
opt.termguicolors = true
opt.background = "dark" -- colorschemes that can be light or dark will be made dark
opt.signcolumn = "yes" -- show sign column so that text doesn't shift
-- opt.colorcolumn = "100"

-- backspace
opt.backspace = "indent,eol,start" -- allow backspace on indent, end of line or insert mode start position

-- clipboard
opt.clipboard:append("unnamedplus") -- use system clipboard as default register

-- split windows
opt.splitright = true -- split vertical window to the right
opt.splitbelow = true -- split horizontal window to the bottom

opt.iskeyword:append("-") -- consider string-string as whole word

opt.fileencoding = "utf-8" -- the encoding written to a file

-- opt.backup = false -- creates a backup file

-- opt.cmdheight = 1 -- more space in the neovim command line for displaying messages

-- opt.completeopt = { "menuone", "noselect" } -- mostly just for cmp

opt.conceallevel = 0 -- so that `` is visible in markdown files

-- opt.showtabline = 2 -- always show tabs

-- opt.timeoutlen = 1000 -- time to wait for a mapped sequence to complete (in milliseconds)

opt.undofile = true -- enable persistent undo

opt.updatetime = 300 -- faster completion (4000ms default)

-- opt.writebackup = false -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited

-- opt.hlsearch = true -- highlight all matches on previous search pattern

opt.scrolloff = 4 -- is one of my fav

-- opt.sidescrolloff = 4

-- turn off swapfile
opt.swapfile = false

-- hide startup empty buffer
opt.hidden = true

-- disable nvim intro
opt.shortmess:append("sI")

-- Maximum item to show in popup menu
opt.pumheight = 10

-- Totally disable statusline
---------------------------------------------
opt.laststatus = 3
-- vim.api.nvim_set_hl(0, "Statusline", { link = "Normal" })
-- vim.api.nvim_set_hl(0, "StatuslineNC", { link = "Normal" })
-- opt.statusline = string.rep("-", vim.api.nvim_win_get_width(0))
-- -- if you want give the line a highlight can be
-- vim.opt.statusline = "%#Myhighlight#" .. "mystring" .. "%*"
