return {
  "nvim-treesitter/nvim-treesitter",

  dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },

  event = { "BufReadPost", "BufNewFile" },

  cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },

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
      "go",
    },

    highlight = {
      enable = true,
      use_languagetree = true,
    },

    indent = { enable = true },
  },

  config = function(_, opts)
    require("nvim-treesitter.configs").setup(opts)
  end,
}
