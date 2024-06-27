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
    return {
      flavour = "mocha",
      integrations = {
        neotree = true,
        mason = true,
        window_picker = true,
        navic = {
          enabled = true,
        },
        -- diffview = true,
        -- which_key = true,
        -- lsp_trouble = true,
      },

      custom_highlights = function(colors)
        return {
          -- Cmp Menu
          -- CmpPmenu = { bg = colors.crust },
          CmpBorder = { fg = colors.overlay2 },
          CmpSel = { link = "PmenuSel", bold = true },
          -- CmpItemMenu = { fg = colors.overlay1, italic = true },
          CmpItemAbbr = { fg = colors.subtext1 },
          CmpItemAbbrMatch = { fg = colors.sapphire, bold = true },
          -- CmpDoc = { bg = colors.crust },
          CmpDocBorder = { fg = colors.overlay2 },

          -- Telescope
          TelescopeBorder = { fg = colors.blue },
          TelescopeSelectionCaret = { fg = colors.red },
          TelescopeSelection = { fg = colors.yellow, bg = colors.surface0, style = { "bold" } },
          TelescopeMatching = { fg = colors.blue },
          TelescopePromptPrefix = { fg = colors.yellow, bg = colors.crust },
          TelescopePromptTitle = { fg = colors.crust, bg = colors.mauve, style = { "bold", "italic" } },
          TelescopePromptNormal = { bg = colors.crust },
          TelescopePromptBorder = { bg = colors.crust, fg = colors.crust },
          TelescopeResultsNormal = { bg = colors.mantle },
          TelescopeResultsTitle = { fg = colors.crust, bg = colors.green, style = { "bold", "italic" } },
          TelescopeResultsBorder = { bg = colors.mantle, fg = colors.mantle },
          TelescopePreviewNormal = { bg = colors.crust },
          TelescopePreviewBorder = { bg = colors.crust, fg = colors.crust },
          TelescopePreviewTitle = { fg = colors.crust, bg = colors.sapphire, style = { "bold", "italic" } },

          -- Cursorline & Linenumbers
          -- CursorLine = { bg = colors.mantle },
          -- Cursor = { bg = colors.red },

          -- Neotree
          NeoTreeRootName = { style = { "bold", "italic" } },
          NeoTreeGitAdded = { fg = colors.green, style = { "italic" } },
          NeoTreeGitConflict = { fg = colors.red, style = { "italic" } },
          NeoTreeGitDeleted = { fg = colors.red, style = { "italic" } },
          NeoTreeGitIgnored = { fg = colors.overlay0, style = { "italic" } },
          NeoTreeGitModified = { fg = colors.yellow, style = { "italic" } },
          NeoTreeGitUnstaged = { fg = colors.red, style = { "italic" } },
          NeoTreeGitUntracked = { fg = colors.teal, style = { "italic" } },
          NeoTreeGitStaged = { fg = colors.green, style = { "italic" } },

          -- Treesitter Context
          TreesitterContext = { bg = colors.mantle },
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
