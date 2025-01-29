return {
  {
    "williamboman/mason.nvim",
    opts = {
      ui = {
        icons = {
          package_installed = " ",
          package_pending = " ",
          package_uninstalled = " ",
        },
        border = "single",
      },
    },
  },
  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      ensure_installed = {
        "lua_ls",
        "pylsp",
        "ts_ls",
        "ruby_lsp",
        "solargraph",
        "jsonls",
        "bashls",
      },
    },
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = {
      ensure_installed = {
        "prettier", -- prettier formatter
        "prettierd",
        "stylua", -- lua formatter
        "eslint_d", -- js/ts linter
        "pylint",
        "black",
        "rubocop",
      },
    },
  },
}
