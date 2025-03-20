vim.cmd("let g:netrw_liststyle = 3") -- Netrw file explorer style

local opt = vim.opt

-- === Line Numbers ===
opt.relativenumber = true
opt.number = true
opt.numberwidth = 4   -- Ensures proper alignment
opt.cursorline = true -- Highlight current line

-- === Tabs & Indentation ===
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true
opt.softtabstop = 2
opt.smartindent = true -- Smarter auto-indentation

-- === Line Wrapping ===
opt.wrap = true
opt.linebreak = true
opt.breakindent = true

-- === Search ===
opt.ignorecase = true
opt.smartcase = true
opt.incsearch = true -- Show matches while typing
opt.hlsearch = true  -- Highlight matches

-- === UI Improvements ===
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"
opt.scrolloff = 4
opt.sidescrolloff = 4      -- Ensures better side scrolling
opt.shortmess:append("sI") -- Disable Neovim intro
opt.laststatus = 3         -- Minimal statusline

-- === Clipboard ===
opt.clipboard:append("unnamedplus")

-- === File & Buffer Management ===
opt.undofile = true    -- Persistent undo history
opt.swapfile = false   -- Disable swapfile
opt.hidden = true      -- Allows switching buffers without saving
opt.bufhidden = "hide" -- Better way to hide buffers
opt.fileencoding = "utf-8"

-- === Splits ===
opt.splitright = true
opt.splitbelow = true

-- === Performance ===
opt.updatetime = 300 -- Faster updates
-- opt.lazyredraw = true -- Improve macro performance
opt.timeoutlen = 500 -- Faster key sequence timeout
opt.pumheight = 10   -- Limit popup menu height

-- === Misc ===
opt.iskeyword:append("-")       -- consider string-string as whole word
opt.conceallevel = 2            -- Hide markdown symbols like **bold** (Set 0 if you prefer visible)
opt.formatoptions:remove("cro") -- Don't auto-comment new lines
