local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
local null_ls = require("null-ls")

local formatting = null_ls.builtins.formatting;
local linter = null_ls.builtins.diagnostics -- to setup linters

local opts = {
  sources = {
    linter.eslint,
    formatting.prettier,
    formatting.gofmt,
    formatting.goimports_reviser,
    formatting.golines,
    formatting.stylua,
  },
  on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({
        group = augroup,
        buffer = bufnr,
      })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({ bufnr = bufnr })
        end,
      })
    end
  end,
}

return opts
