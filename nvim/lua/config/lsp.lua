local keymap = vim.keymap.set -- for conciseness

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(ev)
    local function opts(desc)
      return { buffer = ev.buf, desc = "LSP " .. desc }
    end

    -- KEYMAPS
    keymap("n", "gd", vim.lsp.buf.definition, opts("Goto Definition"))
    keymap("n", "gr", vim.lsp.buf.references, opts("References"))
    keymap("n", "gi", vim.lsp.buf.implementation, opts("Goto Implementation"))
    keymap("n", "gt", vim.lsp.buf.type_definition, opts("Goto Type Definition"))
    keymap("n", "gD", vim.lsp.buf.declaration, opts("Goto Declaration"))
    keymap("n", "gn", vim.lsp.buf.rename, opts("Rename"))
    keymap("n", "gf", vim.lsp.buf.format, opts("Formating"))
    keymap("n", "gc", vim.lsp.buf.code_action, opts("Code Action"))
    keymap("n", "gl", vim.lsp.codelens.run, opts("Code Lens"))
    keymap("n", "gk", vim.lsp.buf.signature_help, opts("Signature Help"))
    keymap("n", "K", vim.lsp.buf.hover, opts("Show documentation for what is under cursor"))
    keymap("i", "<C-k>", vim.lsp.buf.signature_help, opts("Insert Mode Signature Help"))
    keymap("n", "g]", function()
      vim.diagnostic.jump({ count = 1 })
    end, opts("Goto Previous Diagnostic"))
    keymap("n", "g[", function()
      vim.diagnostic.jump({ count = -1 })
    end, opts("Goto Next Diagnostic"))
    keymap("n", "<leader>d", vim.diagnostic.open_float, opts("Open Diagnostic in floating window"))
    -- keymap("n", "<leader>rn", require("plugins.lsp.renamer"), opts("Rename"))
    keymap("n", "<leader>rs", ":LspRestart<CR>", opts("Restart LSP"))
    keymap("n", "<leader>ih", function()
      if vim.lsp.inlay_hint then
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
      end
    end, opts("Toggle Inlay Hints"))

    -- INLAY HINTS
    -- if client.server_capabilities.inlayHintProvider then
    --   vim.lsp.inlay_hint.enable(true)
    -- else
    --   vim.lsp.inlay_hint.enable(false)
    -- end
    -- local client = vim.lsp.get_client_by_id(ev.data.client_id)
  end,
})
