vim.lsp.config("*", {
  capabilities = require("blink.cmp").get_lsp_capabilities(),
})

vim.diagnostic.config({
  virtual_text = {
    source = true,
    prefix = "▎", -- Could be '●', '▎', │, 'x', '■', , 
  },
  jump = {
    float = true,
  },
  float = {
    border = "single",
    -- source = true,
    -- focusable = true,
    -- header = "",
    -- prefix = "",
    max_width = 80, -- adjust as needed
  },
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
    local keymap = vim.keymap.set

    local function opts(desc)
      return { buffer = event.buf, desc = "LSP " .. desc }
    end
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if client and client:supports_method("textDocument/inlayHint") then
      vim.lsp.inlay_hint.enable(true, { bufnr = event.buf })
    end

    local bufname = vim.api.nvim_buf_get_name(event.buf)
    if string.match(bufname, "%.env") then
      vim.diagnostic.enable(false, { bufnr = event.buf })
    end

    -- if client and client:supports_method("textDocument/completion") then
    --   vim.lsp.completion.enable(true, client.id, event.buf, { autotrigger = true })
    -- end

    keymap("n", "K", function()
      vim.lsp.buf.hover({ border = "single", max_height = 10, max_width = 90 })
    end, opts("Hover"))

    keymap("n", "gK", function()
      vim.lsp.buf.signature_help({ border = "single", max_height = 10, max_width = 90 })
    end, opts("Signature Help"))

    keymap("n", "grd", vim.lsp.buf.definition, opts("Go to definition"))
    keymap("n", "grD", vim.lsp.buf.declaration, opts("Go to declaration"))

    keymap("n", "<leader>th", function()
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
    end, opts("Toggle inlay hints"))

    keymap("n", "<leader>d", vim.diagnostic.open_float, opts("Open current diagnostic in float window"))
    keymap("n", "<leader>rs", function()
      vim.cmd(":LspRestart")
    end, opts("Open current diagnostic in float window"))
  end,
})
