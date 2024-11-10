local M = {}

M.diagnostic_config = function()
  -- local signs = { Error = " ", Warn = " ", Hint = "󰌶 ", Info = " " }
  local signs = { Error = "󰅙", Info = "󰋼", Hint = "󰌵", Warn = "" }
  for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
  end

  vim.diagnostic.config({
    virtual_text = { prefix = "" },
    signs = true,
    underline = true,
    float = { border = "single", source = "if_many" },
  })

  -- Default border style
  local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
  function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
    opts = opts or {}
    opts.border = "rounded"
    return orig_util_open_floating_preview(contents, syntax, opts, ...)
  end
end

return M
