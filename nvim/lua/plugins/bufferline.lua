return {
  "akinsho/bufferline.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons", -- OPTIONAL: for file icons
  },

  opts = {
    options = {
      diagnostics = "nvim_lsp",
      always_show_bufferline = true,
      separator_style = "thick", -- | "slope" | "thick" | "thin" | { "any", "any" },
      buffer_close_icon = "󰖭",
      offsets = {
        {
          filetype = "neo-tree",
          text = "File Explorer",
          highlight = "Directory",
          text_align = "center",
        },
      },
    },
  },
  version = "*",
}
