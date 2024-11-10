local M = {}
local keymap = vim.keymap.set -- for conciseness

M.on_attach = function(_, bufnr)
  local function opts(desc)
    return { buffer = bufnr, desc = "LSP " .. desc }
  end

  keymap("n", "gd", vim.lsp.buf.definition, opts("Goto Definition"))
  keymap("n", "gr", vim.lsp.buf.references, opts("References"))
  keymap("n", "gi", vim.lsp.buf.implementation, opts("Goto Implementation"))
  keymap("n", "gt", vim.lsp.buf.type_definition, opts("Goto Type Definition"))
  keymap("n", "gD", vim.lsp.buf.declaration, opts("Goto Declaration"))
  keymap("n", "K", vim.lsp.buf.hover, opts("Show documentation for what is under cursor"))
  keymap("n", "gK", vim.lsp.buf.signature_help, opts("Signature Help"))
  keymap("i", "<C-k>", vim.lsp.buf.signature_help, opts("Signature Help"))
  keymap("n", "gf", vim.lsp.buf.format, opts("LSP Formating"))
  keymap("n", "ca", vim.lsp.buf.code_action, opts("LSP Code Action"))
  keymap("n", "]]", vim.diagnostic.goto_next, opts("Goto Previous Diagnostic"))
  keymap("n", "[[", vim.diagnostic.goto_prev, opts("Goto Next Diagnostic"))
  keymap("n", "<leader>rn", vim.lsp.buf.rename, opts("LSP Rename"))
  keymap("n", "<leader>rs", ":LspRestart<CR>", opts("Restart LSP"))
end

-- disable semanticTokens
M.on_init = function(client, _)
  if client.supports_method("textDocument/semanticTokens") then
    client.server_capabilities.semanticTokensProvider = nil
  end
end

M.capabilities = vim.lsp.protocol.make_client_capabilities()

M.capabilities.textDocument.completion.completionItem = {
  documentationFormat = { "markdown", "plaintext" },
  snippetSupport = true,
  preselectSupport = true,
  insertReplaceSupport = true,
  labelDetailsSupport = true,
  deprecatedSupport = true,
  commitCharactersSupport = true,
  tagSupport = { valueSet = { 1 } },
  resolveSupport = {
    properties = {
      "documentation",
      "detail",
      "additionalTextEdits",
    },
  },
}

M.defaults = function()
  require("plugins.lsp.diagnostic").diagnostic_config()

  require("lspconfig").lua_ls.setup({
    on_attach = M.on_attach,
    capabilities = M.capabilities,
    on_init = M.on_init,

    settings = {
      Lua = {
        diagnostics = {
          globals = { "vim" },
        },
        workspace = {
          library = {
            vim.fn.expand("$VIMRUNTIME/lua"),
            vim.fn.expand("$VIMRUNTIME/lua/vim/lsp"),
            vim.fn.stdpath("data") .. "/lazy/lazy.nvim/lua/lazy",
            "${3rd}/luv/library",
          },
          maxPreload = 100000,
          preloadFileSize = 10000,
        },
      },
    },
  })
end

return M
