return {
  "Wansmer/treesj",

  disable = true,

  keys = {
    "<leader>m",
    "<leader>j",
    "<leader>s",
  },

  dependencies = {
    "nvim-treesitter/nvim-treesitter",
  }, -- if you install parsers with `nvim-treesitter`

  opts = {
    max_join_length = 500,
  },
}
