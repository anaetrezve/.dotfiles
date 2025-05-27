-- Catppuccin Mocha colors palettes
-- rosewater = "#f5e0dc",
-- flamingo = "#f2cdcd",
-- pink = "#f5c2e7",
-- mauve = "#cba6f7",
-- red = "#f38ba8",
-- maroon = "#eba0ac",
-- peach = "#fab387",
-- yellow = "#f9e2af",
-- green = "#a6e3a1",
-- teal = "#94e2d5",
-- sky = "#89dceb",
-- sapphire = "#74c7ec",
-- blue = "#89b4fa",
-- lavender = "#b4befe",
-- text = "#cdd6f4",
-- subtext1 = "#bac2de",
-- subtext0 = "#a6adc8",
-- overlay2 = "#9399b2",
-- overlay1 = "#7f849c",
-- overlay0 = "#6c7086",
-- surface2 = "#585b70",
-- surface1 = "#45475a",
-- surface0 = "#313244",
-- base = "#1e1e2e",
-- mantle = "#181825",
-- crust = "#11111b",

return {
  "catppuccin/nvim",
  lazy = false,
  name = "catppuccin",
  priority = 1000,
  opts = function()
    local ucolors = require("catppuccin.utils.colors")

    return {
      flavour = "mocha",
      integrations = {
        which_key = true,
      },
   custom_highlights = function(colors)
        return {
          FloatBorder = { fg = colors.blue, bg = colors.base },
          NormalFloat = { bg = colors.base },
          -- CursorLineNr = { bg = ucolors.vary_color({ latte = ucolors.lighten(colors.mantle, 0.70, colors.base) }, ucolors.darken(colors.surface0, 0.64, colors.base))}
        }
      end,
    }
  end,

  config = function(_, opts)
    require("catppuccin").setup(opts)
    vim.cmd.colorscheme("catppuccin")
  end,
}

-- `vim.tbl_deep_extend` function which is used for merging tables and their values recursively.
-- local result = vim.tbl_deep_extend("force", hlgroups, styles[telescope_style])
