return {
  "mason-org/mason-lspconfig.nvim",
  dependencies = {
    { "mason-org/mason.nvim", opts = {} },
    "neovim/nvim-lspconfig",
    "saghen/blink.cmp", -- Ensure blink.cmp loads first for capabilities
  },
  config = function()
    -- Set global capabilities from blink.cmp BEFORE enabling any servers
    vim.lsp.config("*", {
      capabilities = require("blink.cmp").get_lsp_capabilities(),
    })

    require("mason-lspconfig").setup({
      ensure_installed = {
        "lua_ls",
        "ts_ls",
        "solargraph",
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
      -- Automatically enable all installed servers
      automatic_enable = true,
    })
  end,
}
