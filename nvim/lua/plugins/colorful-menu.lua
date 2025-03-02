return {
  "xzbdmw/colorful-menu.nvim",

  enabled = true,

  opts = {},

  config = function(_, opts)
    require("colorful-menu").setup(opts)
  end,
}
