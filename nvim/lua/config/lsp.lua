-- NOTE: Global capabilities are set in plugins/mason.lua before servers are enabled
-- This ensures blink.cmp capabilities are applied to all LSP servers

-- Configure ruby_lsp with enhanced settings for gem navigation
-- Uses globally installed ruby-lsp from mise, not Mason
vim.lsp.config("ruby_lsp", {
  init_options = {
    formatter = "auto",
    linters = { "rubocop" },
    -- Explicitly enable all features (important for Sorbet codebases)
    enabledFeatures = {
      codeActions = true,
      codeLens = true,
      completion = true,
      definition = true,
      diagnostics = true,
      documentHighlights = true,
      documentLink = true,
      documentSymbols = true,
      foldingRanges = true,
      formatting = true,
      hover = true,
      inlayHint = true,
      onTypeFormatting = true,
      selectionRanges = true,
      semanticHighlighting = true,
      signatureHelp = true,
      typeHierarchy = true,
      workspaceSymbol = true,
    },
    indexing = {
      -- Include all gems including development dependencies
      includedGems = {},
      excludedGems = {},
    },
    addonSettings = {
      ["Ruby LSP Rails"] = {
        enablePendingMigrationsPrompt = false,
      },
    },
  },
})
vim.lsp.enable("ruby_lsp")

-- Configure Sorbet LSP for typed Ruby files (provides better type info for typed: true/strict files)
vim.lsp.config("sorbet", {
  cmd = { "bundle", "exec", "srb", "tc", "--lsp", "--enable-all-experimental-lsp-features" },
  root_markers = { "sorbet/config" },
})
vim.lsp.enable("sorbet")

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

    local bufname = vim.api.nvim_buf_get_name(event.buf)
    if string.match(bufname, "%.env") then
      vim.diagnostic.enable(false, { bufnr = event.buf })
    end

    -- ESLint auto-fix on save (disabled - causes slow saves in large monorepos)
    -- Use <leader>ca to manually apply ESLint fixes when needed
    -- if client and client.name == "eslint" then
    --   vim.api.nvim_create_autocmd("BufWritePre", {
    --     buffer = event.buf,
    --     callback = function()
    --       local bufnr = event.buf
    --       local eslint_client = vim.lsp.get_clients({ name = "eslint", bufnr = bufnr })[1]
    --       if not eslint_client then
    --         return
    --       end
    --
    --       -- Request code actions synchronously so fix completes before save
    --       local range_params = vim.lsp.util.make_range_params(nil, eslint_client.offset_encoding)
    --       local params = {
    --         textDocument = range_params.textDocument,
    --         range = range_params.range,
    --         context = {
    --           ---@diagnostic disable-next-line: assign-type-mismatch
    --           only = { "source.fixAll.eslint" },
    --           diagnostics = vim.diagnostic.get(bufnr),
    --         },
    --       }
    --       local result = vim.lsp.buf_request_sync(bufnr, "textDocument/codeAction", params, 3000)
    --       if result then
    --         for _, res in pairs(result) do
    --           if res.result then
    --             for _, action in ipairs(res.result) do
    --               if action.edit then
    --                 vim.lsp.util.apply_workspace_edit(action.edit, eslint_client.offset_encoding)
    --               elseif action.command then
    --                 eslint_client:exec_cmd(action.command, { bufnr = bufnr })
    --               end
    --             end
    --           end
    --         end
    --       end
    --     end,
    --   })
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
    end, opts("Restart LSP"))
  end,
})
