return {
	"williamboman/mason.nvim",
	opts = {
		ui = {
			icons = {
				package_installed = " ",
				package_pending = " ",
				package_uninstalled = " ",
			},
			border = "single",
		},
	},
	config = function(_, opts)
		require("mason").setup(opts)
	end,
}
