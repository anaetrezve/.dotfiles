return {
  "Wansmer/treesj",

  enabled = true,

  keys = {
    { "<leader>gt", "<CMD>:TSJToggle<CR>", desc = "Toggle splitjoin block" },
    { "<leader>gs", "<CMD>:TSJSplit<CR>", desc = "Split block" },
    { "<leader>gj", "<CMD>:TSJJoin<CR>", desc = "Join block" },
  },

  dependencies = {
    "nvim-treesitter/nvim-treesitter",
  },

  opts = {
    max_join_length = 500,
    use_default_keymaps = false,
  },
}
