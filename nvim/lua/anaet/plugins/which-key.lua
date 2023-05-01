local which_key = require("which-key")

local opts = { prefix = "<leader>" }
local mappings = {
	q = { "<cmd>q<cr>", "Quit" },
}

which_key.setup({})
which_key.register(mappings, opts)
