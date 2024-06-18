return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre", -- uncomment for format on save
    config = function()
      require("configs.conform")
    end,
  },
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local lint = require("lint")

      lint.linters_by_ft = {
        javascript = { "eslint_d" },
        typescript = { "eslint_d" },
        javascriptreact = { "eslint_d" },
        typescriptreact = { "eslint_d" },
        svelte = { "eslint_d" },
        python = { "pylint" },
      }

      local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

      vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
        group = lint_augroup,
        callback = function()
          lint.try_lint()
        end,
      })

      vim.keymap.set("n", "<leader>l", function()
        lint.try_lint()
      end, { desc = "Trigger linting for current file" })
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
        "gopls",
        "cssls",
        "tailwindcss-language-server",
        "lua_ls",
        "emmet_ls",
        "eslint-lsp",
        "js-debug-adapter",
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
  {
    "nvim-tree/nvim-tree.lua",
    enabled = false,
  },
}
