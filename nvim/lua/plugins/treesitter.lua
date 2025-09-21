return {
  {
    "nvim-treesitter/nvim-treesitter",

    dependencies = {
      { "nvim-treesitter/nvim-treesitter-textobjects" },
      {
        "nvim-treesitter/nvim-treesitter-context",
        enabled = false,
        opts = {},
      },
    },

    event = { "BufReadPost", "BufNewFile" },
    cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
    build = ":TSUpdate",

    opts = {
      auto_install = true,

      highlight = {
        enable = true,
      },

      indent = { enable = true },
    },

    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },

  {
    "windwp/nvim-ts-autotag",
    event = { "BufReadPre", "BufNewFile" },
    opts = {},
  },

  {
    "ckolkey/ts-node-action",
    keys = {
      { "+", "<cmd>NodeAction<cr>", desc = "Trigger Node Action" },
    },
    opts = {},
  },
}
