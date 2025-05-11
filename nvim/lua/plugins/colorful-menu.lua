return {
  "xzbdmw/colorful-menu.nvim",

  enabled = false,

  opts = {},

  config = function(_, opts)
    require("colorful-menu").setup(opts)
  end,
}
