local M = {}
local keymap = vim.keymap.set -- for conciseness
local servers = require("plugins.lsp.servers")

M.on_attach = function(client, bufnr)
  local function opts(desc)
    return { buffer = bufnr, desc = "LSP " .. desc }
  end

  -- KEYMAPS
  keymap("n", "gd", vim.lsp.buf.definition, opts("Goto Definition"))
  keymap("n", "gr", vim.lsp.buf.references, opts("References"))
  keymap("n", "gi", vim.lsp.buf.implementation, opts("Goto Implementation"))
  keymap("n", "gt", vim.lsp.buf.type_definition, opts("Goto Type Definition"))
  keymap("n", "gD", vim.lsp.buf.declaration, opts("Goto Declaration"))
  keymap("n", "gn", vim.lsp.buf.rename, opts("Rename"))
  keymap("n", "gf", vim.lsp.buf.format, opts("Formating"))
  keymap("n", "gca", vim.lsp.buf.code_action, opts("Code Action"))
  keymap("n", "gk", vim.lsp.buf.signature_help, opts("Signature Help"))
  keymap("n", "K", vim.lsp.buf.hover, opts("Show documentation for what is under cursor"))
  keymap("i", "<C-k>", vim.lsp.buf.signature_help, opts("Insert Mode Signature Help"))
  keymap("n", "g]", vim.diagnostic.goto_next, opts("Goto Previous Diagnostic"))
  keymap("n", "g[", vim.diagnostic.goto_prev, opts("Goto Next Diagnostic"))
  keymap("n", "<leader>rn", require("plugins.lsp.renamer"), opts("Rename"))
  keymap("n", "<leader>rs", ":LspRestart<CR>", opts("Restart LSP"))
  keymap("n", "<leader>ih", function()
    if vim.lsp.inlay_hint then
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
    end
  end, opts("Toggle Inlay Hints"))

  -- INLAY HINTS
  if client.server_capabilities.inlayHintProvider then
    vim.lsp.inlay_hint.enable(true)
  else
    vim.lsp.inlay_hint.enable(false)
  end
end

M.handlers = function()
  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "single",
    silent = true,
    max_height = 15,
    max_width = 80,
  })

  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = "single",
    silent = true,
    max_height = 15,
    max_width = 80,
  })
end

-- disable semanticTokens
-- M.on_init = function(client, _)
--   if client.supports_method("textDocument/semanticTokens") then
--     client.server_capabilities.semanticTokensProvider = nil
--   end
-- end
--
-- M.capabilities = require("cmp_nvim_lsp").default_capabilities()
-- M.capabilities.textDocument.foldingRange = {
--   dynamicRegistration = false,
--   lineFoldingOnly = true,
-- }

-- M.capabilities = vim.lsp.protocol.make_client_capabilities()
--
-- M.capabilities.textDocument.completion.completionItem = {
--   documentationFormat = { "markdown", "plaintext" },
--   snippetSupport = true,
--   preselectSupport = true,
--   insertReplaceSupport = true,
--   labelDetailsSupport = true,
--   deprecatedSupport = true,
--   commitCharactersSupport = true,
--   tagSupport = { valueSet = { 1 } },
--   resolveSupport = {
--     properties = {
--       "documentation",
--       "detail",
--       "additionalTextEdits",
--     },
--   },
-- }

M.defaults = function()
  local lspconfig = require("lspconfig")
  local blink = require("blink.cmp")
  require("plugins.lsp.diagnostic").diagnostic_config()

  M.handlers()

  for server, config in pairs(servers) do
    config.capabilities = blink.get_lsp_capabilities(config.capabilities)
    config.on_attach = M.on_attach

    lspconfig[server].setup(config)
  end
end

return M
