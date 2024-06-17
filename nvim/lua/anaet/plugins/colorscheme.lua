return {
  "catppuccin/nvim",
  lazy = false,
  name = "catppuccin",
  priority = 1000,
  opts = function()
    local ucolors = require("catppuccin.utils.colors")
    local mocha = require("catppuccin.palettes").get_palette("mocha")

    return {
      flavour = "mocha",
      integrations = {
        neotree = true,
        mason = true,
        window_picker = true,
        diffview = true,
        which_key = true,
        lsp_trouble = true,
      },
      custom_highlights = function(colors)
        return {}
      end,
    }
  end,

  config = function(_, opts)
    require("catppuccin").setup(opts)
    vim.cmd.colorscheme("catppuccin")
  end,
}
