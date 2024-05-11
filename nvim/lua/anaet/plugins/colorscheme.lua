return {
	"catppuccin/nvim",
	lazy = false,
	name = "catppuccin",
	priority = 1000,
	config = function(_, opts)
		require("catppuccin").setup(opts)
		vim.cmd.colorscheme("catppuccin")
	end,
	opt = {
    flavour = "mocha", -- latte, frappe, macchiato, mocha
    integrations = {
      neotree = true
    }
  },
}
