return {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPost", "BufNewFile" },
  build = ":TSUpdate",
  opts = {
    ensure_installed = {
      "lua",
      "luadoc",
      "printf",
      "vim",
      "vimdoc",
      "bash",
      "css",
      "csv",
      "dockerfile",
      "go",
      "gomod",
      "gosum",
      "graphql",
      "html",
      "json",
      "json5",
      "jsonc",
      "javascript",
      "markdown_inline",
      "gitignore",
      "diff",
      "git_config",
      "comment",
      "python",
      "rust",
      "scss",
      "styled",
      "tmux",
      "toml",
      "tsv",
      "tsx",
      "typescript",
      "yaml",
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
