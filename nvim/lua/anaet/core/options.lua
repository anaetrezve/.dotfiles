-- Set netrw style 3
vim.cmd("let g:netrw_liststyle = 3")

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- [[ Setting options ]]
-- See `:help opt`
-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`

-- setting local opt variable for conciseness
local opt = vim.opt

-- Make line numbers default
opt.number = true

-- You can also add relative line numbers, to help with jumping.
--  Experiment for yourself to see if you like it!
opt.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
opt.mouse = "a"

-- Don't show the mode, since it's already in the status line
opt.showmode = false

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
-- use system clipboard as default register
-- opt.clipboard = "unnamedplus"
opt.clipboard:append("unnamedplus")

-- Enable break indent
opt.breakindent = true

-- Save undo history
opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
opt.ignorecase = true
opt.smartcase = true

-- Keep signcolumn on by default
opt.signcolumn = "yes"

-- Decrease update time
opt.updatetime = 250

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
opt.timeoutlen = 300

-- Configure how new splits should be opened
opt.splitright = true
opt.splitbelow = true

-- Preview substitutions live, as you type!
opt.inccommand = "split"

-- Show which line your cursor is on
opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
opt.scrolloff = 10

-- Set highlight on search
opt.hlsearch = true

-- tabs & indentation
-- 2 spaces for tabs (prettier default)
-- 2 spaces for indent width
-- expand tab to spaces
-- copy indent from current line when starting new one
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true

-- turn on termguicolors for nightfly colorscheme to work
-- (have to use iterm2 or any other true color terminal)
opt.termguicolors = true

-- allow backspace on indent, end of line or insert mode start position
opt.backspace = "indent,eol,start"

-- consider string-string as whole word
opt.iskeyword:append("-")

-- the encoding written to a file
opt.fileencoding = "utf-8"

-- so that `` is visible in markdown files
opt.conceallevel = 0

-- hide startup empty buffer
opt.hidden = true

opt.fixendofline = true
