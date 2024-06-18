return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre", -- uncomment for format on save
    config = function()
      require("configs.conform")
    end,
  },
  {
    "christoomey/vim-tmux-navigator",
    lazy = false,
  },
  {
    "hrsh7th/nvim-cmp",
    opts = function()
      local conf = require("nvchad.configs.cmp")
      conf.mapping["<C-k>"] = require("cmp").mapping.select_prev_item() -- previous suggestion
      conf.mapping["<C-j>"] = require("cmp").mapping.select_next_item() -- next suggestion
      conf.mapping["<C-d>"] = require("cmp").mapping.scroll_docs(-4)
      conf.mapping["<C-u>"] = require("cmp").mapping.scroll_docs(4)
      conf.mapping["<Tab>"] = require("cmp").mapping.confirm({
        behavior = require("cmp").ConfirmBehavior.Insert,
        select = true,
      })

      -- conf.experimental.ghost_text = true

      return conf
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
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "lua-language-server",
        "stylua",
        "html-lsp",
        "css-lsp",
        "prettier",
        "gopls",
        "cssls",
        "tailwindcss-language-server",
        "lua_ls",
        "emmet_ls",
        "eslint-lsp",
        "js-debug-adapter",
        "prettier",
        "typescript-language-server",
        "stylelint_lsp",
        "jsonls",
        "graphql",

        "prettier", -- prettier formatter
        -- "isort", -- python formatter
        -- "black", -- python formatter
        -- "pylint",
        "eslint_d",
      },
    },
  },
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
  {
    "nvim-telescope/telescope.nvim",
    opts = function()
      local conf = require("nvchad.configs.telescope")

      conf.defaults.mappings.i = {
        ["<C-k>"] = require("telescope.actions").move_selection_previous,
        ["<C-j>"] = require("telescope.actions").move_selection_next,
        ["<Esc>"] = require("telescope.actions").close,
      }
      conf.defaults.mappings.n = {
        ["<C-k>"] = require("telescope.actions").move_selection_previous,
        ["<C-j>"] = require("telescope.actions").move_selection_next,
        ["<Esc>"] = require("telescope.actions").close,
      }

      return conf
    end,
  },
}
