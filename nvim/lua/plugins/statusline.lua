return {
  dir = "~/.dotfiles/nvim-plugins/rezline.nvim",

  config = function()
    require("rezline").setup()
  end,
}
