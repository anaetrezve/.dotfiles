return {
  "mason-org/mason-lspconfig.nvim",
  opts = {
    ensure_installed = {
      "lua_ls",
      "ruby_lsp",
      "ts_ls",
      -- "gopls",
      "pylsp",
      "rust_analyzer",
      "yamlls",
      "bashls",
      "cssls",
      "dockerls",
      "jsonls",
      "marksman",
      "tailwindcss",
      "terraformls",
    },
  },
  dependencies = {
    { "mason-org/mason.nvim", opts = {} },
    "neovim/nvim-lspconfig",
  },
}
