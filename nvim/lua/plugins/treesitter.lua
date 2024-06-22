return {
  "nvim-treesitter/nvim-treesitter",
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

      -- "printf",
      -- "css",
      -- "csv",
      -- "dockerfile",
      -- "go",
      -- "gomod",
      -- "gosum",
      -- "graphql",
      -- "html",
      -- "json",
      -- "json5",
      -- "jsonc",
      -- "markdown_inline",
      -- "gitignore",
      -- "diff",
      -- "git_config",
      -- "comment",
      -- "python",
      -- "rust",
      -- "scss",
      -- "styled",
      -- "tmux",
      -- "toml",
      -- "tsv",
      -- "yaml",
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
