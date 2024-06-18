require("nvchad.options")

-- add yours here!

local o = vim.o
local opt = vim.opt

-- o.cursorlineopt ='both' -- to enable cursorline!
o.scrolloff = 5

opt.iskeyword:append("-") -- consider string-string as whole word
