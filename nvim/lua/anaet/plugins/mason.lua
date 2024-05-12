return {
	"williamboman/mason.nvim",
	config = function(_, opts)
		require("mason").setup(opts)
	end,
	opts = {},
}
