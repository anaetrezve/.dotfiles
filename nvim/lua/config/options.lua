-- vim.g.netrw_liststyle = 3 -- More modern Netrw style

local opt = vim.opt

-- === Modernized Options for Neovim 0.11+ ===

-- === Line Numbers ===
-- opt.relativenumber = true -- Show relative line numbers for easier navigation
opt.number = true -- Show absolute line number for the current line
opt.numberwidth = 3 -- Set the width of the number column
opt.cursorline = true -- Highlight the current line for better focus

-- === Tabs & Indentation ===
opt.tabstop = 2 -- Number of spaces a tab counts for
opt.shiftwidth = 2 -- Number of spaces to use for each step of (auto)indent
opt.expandtab = true -- Convert tabs to spaces
opt.autoindent = true -- Copy indent from the current line when starting a new line
opt.softtabstop = 2 -- Number of spaces a tab counts for while editing
opt.smartindent = true -- Automatically insert indents in some cases
opt.copyindent = true
opt.breakindent = true

-- === Line Wrapping ===
opt.wrap = true -- Enable line wrapping
opt.linebreak = true -- Wrap lines at word boundaries
opt.breakindent = true -- Preserve indentation for wrapped lines

-- === Search ===
opt.ignorecase = true -- Ignore case in search patterns
opt.smartcase = true -- Override ignorecase if search pattern contains uppercase letters
opt.incsearch = true -- Show search matches as you type
-- opt.hlsearch = false -- Only show matches while typing, don't persist highlights

-- === UI Improvements ===
opt.termguicolors = true -- Enable 24-bit RGB color in the TUI
opt.background = "dark" -- Set background color scheme to dark
opt.signcolumn = "yes" -- Always show the sign column
opt.scrolloff = 8 -- Keep 8 lines visible above and below the cursor
opt.sidescrolloff = 8 -- Keep 8 columns visible to the left and right of the cursor
opt.shortmess:append("sI") -- Hide startup message
opt.laststatus = 3 -- Use a global statusline
opt.cmdheight = 0 -- Minimal command line height
-- opt.title = true           -- Set the window title to the filename
-- opt.listchars:append({ precedes = '«', extends = '»', tab = '»-', trail = '·' })
opt.guicursor = table.concat({ -- Customize cursor shapes
  "n-v-c:block-blinkon500-blinkoff500-blinkwait500", -- Normal/Visual/Command: blinking block
  "i-ci-ve:ver25-blinkon500-blinkoff500-blinkwait500", -- Insert modes: blinking vertical bar
  "r-cr:hor20-blinkon500-blinkoff500-blinkwait500", -- Replace modes: blinking horizontal
  "o:hor50", -- Operator-pending (static horizontal bar)
  "sm:block-blinkon250-blinkoff250-blinkwait250", -- ShowMatch: faster blink
}, ",")
opt.smoothscroll = true -- Enable smooth scrolling for better navigation

-- === Spell Checker ===
opt.spell = true -- Disabled by default, enable per-file
opt.spelllang = { "en_us" } -- Set default spell check language
opt.spelloptions:append("camel") -- Better spell checking for camelCase
opt.spellsuggest = "best,9" -- Show up to 9 suggestions
opt.spellcapcheck = "" -- Disable sentence-start capitalization check

-- === Clipboard ===
opt.clipboard:prepend("unnamedplus") -- Use system clipboard as default yank/paste

-- === File & Buffer Management ===
opt.undofile = true -- Enable persistent undo
opt.swapfile = false -- Disable swapfile creation
opt.hidden = true -- Allow switching buffers without saving
opt.bufhidden = "hide" -- Hide buffers instead of closing them
opt.fileencoding = "utf-8" -- Set file encoding to UTF-8
opt.encoding = "utf-8" -- Optional, default is utf-8 anyway

-- === Splits ===
opt.splitright = true -- Open vertical splits to the right
opt.splitbelow = true -- Open horizontal splits below

-- === Performance ===
opt.updatetime = 200 -- Slightly faster updates for things like CursorHold
opt.timeoutlen = 300 -- Better responsiveness for mappings
opt.pumheight = 5 -- Limit the height of the popup menu
opt.lazyredraw = true -- (Re-)enable for better macro performance

-- === Misc ===
opt.iskeyword:append("-") -- Treat words with dashes as a single word
opt.conceallevel = 0 -- Show all text normally
opt.completeopt = { "menu", "menuone", "noselect" } -- Recommended for completion behavior

-- === Folding (VS Code-like) ===
opt.foldcolumn = "0"
opt.foldlevel = 99
opt.foldlevelstart = 99
-- opt.foldenable = true
-- opt.foldnestmax = 4
opt.foldmethod = "expr"
opt.foldtext = ""
opt.foldexpr = "v:lua.vim.lsp.foldexpr()"
-- opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
opt.foldopen:remove("hor") -- Disable horizontal movement from opening folds
-- opt.fillchars:append({     -- Modernize UI separators
--   fold = ' ',
--   foldsep = ' ',
--   foldopen = '',
--   foldclose = '',
--   eob = ' ',
--   horiz = '━',
--   horizup = '┻',
--   horizdown = '┳',
--   vert = '┃',
--   vertleft = '┫',
--   vertright = '┣',
--   verthoriz = '╋'
-- })

-- === BACKUP ===
opt.backup = false
opt.writebackup = false

opt.inccommand = "split"
vim.o.winborder = "single"
