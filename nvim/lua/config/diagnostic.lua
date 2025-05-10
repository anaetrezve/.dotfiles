vim.diagnostic.config({
  virtual_text = true,
  update_in_insert = true,
  underline = true,
  severity_sort = true,
  float = {
    focusable = true,
    style = "minimal",
    border = "rounded",
    source = true,
    header = "",
    prefix = "",
  },
  signs = {
    text = {
      [vim.diagnostic.severity.HINT] = " ",
      [vim.diagnostic.severity.INFO] = " ",
      [vim.diagnostic.severity.WARN] = " ",
      [vim.diagnostic.severity.ERROR] = " ",
    },
    highlights = {
      [vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
      [vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
      [vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
      [vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
    },
    numhl = {
      [vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
      [vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
      [vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
      [vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
    },
    -- linehl = {
    --   [vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
    --   [vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
    --   [vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
    --   [vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
    -- },
  },
})
