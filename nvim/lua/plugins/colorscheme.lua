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
      -- transparent_background = true,
      styles = {
        keywords = { "italic" },
        variables = { "italic" },
        booleans = { "italic" },
        properties = { "italic" },
      },
      -- Integrations
      integrations = {
        neotree = true,
        blink_cmp = true,
        which_key = true,
        window_picker = true,
        colorful_winsep = {
          enabled = true,
          color = "red",
        },
        flash = true,
        grug_far = true,
        hop = true,
        lsp_trouble = true,
        mason = true,
        native_lsp = {
          enabled = true,
          underlines = {
            errors = { "undercurl" },
            hints = { "undercurl" },
            warnings = { "undercurl" },
            information = { "undercurl" },
          },
          inlay_hints = {
            background = false,
          },
        },
        navic = {
          enabled = true,
        },
        noice = true,
        notify = true,
        nvim_surround = true,
        nvimtree = false,
      },

      custom_highlights = function(colors)
        return {
          ["@comment.danger"] = { bg = colors.red, fg = colors.mantle, style = {} },

          FloatBorder = { fg = colors.blue, bg = colors.base },
          NormalFloat = { bg = colors.base },

          -- Cmp Menu
          -- NVChad Style
          PmenuSel = { bg = colors.blue, fg = colors.base },
          -- CmpBorder = { fg = colors.mantle },
          -- CmpBorder = { fg = colors.subtext0 },
          CmpItemAbbr = { fg = colors.text },
          CmpItemAbbrMatch = { fg = colors.blue, bold = true },
          CmpItemAbbrMatchFuzzy = { fg = colors.blue, bold = true },

          -- CmpDoc = { bg = colors.mantle },
          -- CmpDocBorder = { bg = colors.mantle, fg = colors.mantle },
          CmpPmenu = { bg = colors.base },
          CmpSel = { link = "PmenuSel", bold = true },

          -- Custom Style
          -- CmpMenu = { bg = colors.base },
          -- CmpMenuBorder = { fg = colors.overlay0 },
          -- CmpSelectedLine = { bg = colors.surface0 },
          -- CmpItemAbbr = { fg = colors.text },
          -- CmpItemAbbrMatch = { fg = colors.mauve, bold = true },
          -- CmpItemAbbrMatchFuzzy = { fg = colors.mauve, bold = true },
          -- CmpDoc = { bg = colors.base },
          -- CmpDocBorder = { fg = colors.overlay0 },

          -- Telescope
          TelescopeBorder = { fg = colors.blue },
          TelescopeSelectionCaret = { fg = colors.red },
          TelescopeSelection = { fg = colors.text, bg = colors.surface0, style = {} },
          TelescopeMatching = { fg = colors.peach },
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
          TelescopeParent = { fg = colors.surface0, bg = "None" },

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
          -- TreesitterContext = { bg = colors.mantle },
          TreesitterContext = { bg = ucolors.darken(colors.base, 0.55, colors.mantle) },
          TreesitterContextBottom = { sp = colors.surface1 },
          TreesitterContextLineNumber = {
            fg = colors.rosewater,
            bg = ucolors.darken(colors.base, 0.55, colors.mantle),
          },

          -- Diagnostics
          DiagnosticVirtualTextWarn = { bg = "None" },
          DiagnosticVirtualTextInfo = { bg = "None" },
          DiagnosticVirtualTextHint = { bg = "None" },
          DiagnosticVirtualTextError = { bg = "None" },
          DiagnosticVirtualTextOk = { bg = "None" },

          -- Mini
          MiniCursorword = { bg = colors.surface0, style = {} },
          MiniCursorwordCurrent = { bg = colors.surface0, style = {} },

          -- Dashboard
          DashboardFooter = { fg = colors.overlay2 },

          LspSignatureActiveParameter = { fg = colors.crust, bg = colors.green },

          -- Search
          CurSearch = { bg = ucolors.darken(colors.lavender, 0.65, colors.base), fg = colors.mantle },

          -- Lazy.nvim
          LazyButton = { bg = colors.mantle },

          -- Mason
          MasonHeader = { bg = colors.mauve, fg = colors.mantle },
          MasonHighlightBlockBold = { bg = colors.blue, fg = colors.mantle },
          MasonMutedBlock = { bg = colors.surface0, fg = colors.text },

          -- blink.cmp
          BlinkCmpMenuBorder = { fg = colors.blue },
          BlinkCmpDocBorder = { fg = colors.sapphire },
          BlinkCmpSignatureHelpBorder = { fg = colors.yellow },

          -- Folds
          -- Folded = { bg = colors.mantle },
          Folded = { bg = ucolors.darken(colors.peach, 0.1, colors.base) },
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
