return {
  "kylechui/nvim-surround",

  enabled = false,

  event = { "BufReadPre", "BufNewFile" },

  version = "*", -- Use for stability; omit to use `main` branch for the latest features

  opts = {
    highlight_duration = 1000,
  },

  config = true,
}
