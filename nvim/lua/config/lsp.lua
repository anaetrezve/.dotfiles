local keymap = vim.keymap.set

vim.lsp.config("*", {
  capabilities = require("blink.cmp").get_lsp_capabilities(),
})

-- getting all filenames from lsp directory
-- and extracting filenames without extension and enabling lsp
for _, v in ipairs(vim.api.nvim_get_runtime_file("lsp/*", true)) do
  vim.lsp.enable(vim.fn.fnamemodify(v, ":t:r"))
end

vim.diagnostic.config({
  virtual_text = {
    prefix = "▎", -- Could be '●', '▎', │, 'x', '■', , 
  },
  jump = {
    float = true,
  },
  float = { border = "single" },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = " ",
      [vim.diagnostic.severity.WARN] = " ",
      [vim.diagnostic.severity.HINT] = "󰌶 ",
      [vim.diagnostic.severity.INFO] = " ",
    },
    numhl = {
      [vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
      [vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
      [vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
      [vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
    },
  },
})

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
  callback = function(event)
    local function opts(desc)
      return { buffer = event.buf, desc = "LSP " .. desc }
    end

    keymap("n", "gk", vim.lsp.buf.signature_help, opts("Signature Help"))
  end,
})
