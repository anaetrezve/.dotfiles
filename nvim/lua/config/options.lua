vim.g.netrw_liststyle = 3 -- More modern Netrw style

local opt = vim.opt

-- === Line Numbers ===
opt.relativenumber = true
opt.number = true
opt.numberwidth = 4
opt.cursorline = true

-- === Tabs & Indentation ===
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true
opt.softtabstop = 2
opt.smartindent = true

-- === Line Wrapping ===
opt.wrap = true
opt.linebreak = true
opt.breakindent = true

-- === Search ===
opt.ignorecase = true
opt.smartcase = true
opt.incsearch = true
opt.hlsearch = false -- Recommended: only show matches while typing, don't persist highlights

-- === UI Improvements ===
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"
opt.scrolloff = 8           -- More comfortable vertical context
opt.sidescrolloff = 8       -- More horizontal context
opt.shortmess:append("sI")  -- Hide startup message
opt.laststatus = 3          -- Global statusline (preferred in 0.11+)

opt.guicursor = table.concat({
  "n-v-c:block-blinkon500-blinkoff500-blinkwait500",  -- Normal/Visual/Command: blinking block
  "i-ci-ve:ver25-blinkon500-blinkoff500-blinkwait500", -- Insert modes: blinking vertical bar
  "r-cr:hor20-blinkon500-blinkoff500-blinkwait500",    -- Replace modes: blinking horizontal
  "o:hor50", -- Operator-pending (static horizontal bar)
  "sm:block-blinkon250-blinkoff250-blinkwait250"       -- ShowMatch: faster blink
}, ",")
opt.smoothscroll = true     -- Enable smooth scrolling

-- === Spell Checker ===
opt.spell = false                          -- Disabled by default, enable per-file
opt.spelllang = { "en_us" }
opt.spelloptions:append("camel")
opt.spellsuggest = "best,9"               -- Minor fix: actually show up to 9 suggestions
opt.spellcapcheck = ""                    -- Disable sentence-start capitalization check

-- === Clipboard ===
opt.clipboard:prepend("unnamedplus")      -- Use system clipboard as default yank/paste

-- === File & Buffer Management ===
opt.undofile = true
opt.swapfile = false
opt.hidden = true
opt.bufhidden = "hide"
opt.fileencoding = "utf-8"
opt.encoding = "utf-8" -- Optional, default is utf-8 anyway

-- === Splits ===
opt.splitright = true
opt.splitbelow = true

-- === Performance ===
opt.updatetime = 200         -- Slightly faster updates for things like CursorHold
opt.timeoutlen = 300         -- Better responsiveness for mappings
opt.pumheight = 10
opt.lazyredraw = true        -- (Re-)enable for better macro performance

-- === Misc ===
opt.iskeyword:append("-")
opt.conceallevel = 0
-- opt.formatoptions:remove({ "c", "r", "o" }) -- Don't continue comments automatically ( does not work )

-- === Completion ===
opt.completeopt = { "menu", "menuone", "noselect" } -- Recommended for completion behavior

-- === Folds (optional but modern) ===
opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"
opt.foldlevel = 99
