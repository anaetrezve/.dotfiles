return {
  "nvim-treesitter/nvim-treesitter",

  dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },

  event = { "BufReadPost", "BufNewFile" },

  build = ":TSUpdate",

  opts = {
    ensure_installed = {
      "vim",
      "vimdoc",
      "lua",
      "luadoc",
      "bash",

      "javascript",
      "tsx",
      "typescript",
    },
    auto_install = true,

    highlight = {
      enable = true,
      use_languagetree = true,
    },

    indent = { enable = true },
  },
}
