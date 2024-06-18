return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre", -- uncomment for format on save
    config = function()
      require "configs.conform"
    end,
  },

  -- These are some examples, uncomment them if you want to see them work!
  -- {
  --   "neovim/nvim-lspconfig",
  --   config = function()
  --     require("nvchad.configs.lspconfig").defaults()
  --     require "configs.lspconfig"
  --   end,
  -- },
  --
  -- {
  -- 	"williamboman/mason.nvim",
  -- 	opts = {
  -- 		ensure_installed = {
  -- 			"lua-language-server", "stylua",
  -- 			"html-lsp", "css-lsp" , "prettier"
  -- 		},
  -- 	},
  -- },
  --
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        -- defaults
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
        "jsdoc",
      },
    },
  },
}
