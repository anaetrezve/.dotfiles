-- EXAMPLE
local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"
local servers = {
  "css-lsp",
  "cssls",
  "emmet_ls",
  "eslint_d",
  "html",
  "html-lsp",
  "intelephense",
  "jdtls",
  "jsonls",
  "ltex",
  "lua-language-server",
  "lua_ls",
  "prettier",
  "pyright",
  "rust_analyzer",
  "stylua",
  "texlab",
  "tsserver",
  "volar",
  "yamlls",
}

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
  }
end

-- typescript
lspconfig.tsserver.setup {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
}
