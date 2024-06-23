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
        -- diffview = true,
        -- which_key = true,
        -- lsp_trouble = true,
      },
    }
  end,

  config = function(_, opts)
    require("catppuccin").setup(opts)

    vim.cmd.colorscheme("catppuccin")
  end,
}

-- `vim.tbl_deep_extend` function which is used for merging tables and their values recursively.
-- local result = vim.tbl_deep_extend("force", hlgroups, styles[telescope_style])
