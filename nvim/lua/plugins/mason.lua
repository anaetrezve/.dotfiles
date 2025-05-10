return {
  {
    "mason-org/mason.nvim",
    build = ":MasonUpdate",
    opts = {
      ui = {
        icons = {
          package_installed = " ",
          package_pending = " ",
          package_uninstalled = " ",
        },
        border = "single",
        height = 0.8,
      },
    },
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = {
      ensure_installed = {
        "prettier",
        "stylua",
        "eslint_d",
        "rubocop",
        "pylint",
      },
    },
  },
  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = { "neovim/nvim-lspconfig" },
    opts = {
      ensure_installed = {
        "lua_ls",
        "bashls",
        "cssls",
        "docker_compose_language_service",
        "dockerls",
        "jsonls",
        "pylsp",
        "pyright",
        "ruby_lsp",
        "ts_ls",
        "yamlls",
      },
      automatic_enable = true,
    },
  },
}
