return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
	},
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

		require("mason-lspconfig").setup({
			ensure_installed = {
				"lua_ls",
			},
		})
	end,
}
