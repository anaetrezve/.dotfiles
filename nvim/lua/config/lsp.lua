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

-- Sorbet LSP disabled - ruby_lsp has built-in Sorbet support via addons
-- Uncomment if you need real-time Sorbet type checking:
-- vim.lsp.config("sorbet", {
--   cmd = { "bundle", "exec", "srb", "tc", "--lsp", "--enable-all-experimental-lsp-features", "--disable-watchman" },
--   root_markers = { "sorbet/config" },
-- })
-- vim.lsp.enable("sorbet")

-- Configure stree LSP
vim.lsp.config("stree", {
  cmd = { "stree", "lsp" },
  root_markers = { "Gemfile", ".streerc" },
})
vim.lsp.enable("stree")

-- Configure rubocop LSP
vim.lsp.config("rubocop", {
  cmd = { "bundle", "exec", "rubocop", "--lsp" },
})
vim.lsp.enable("rubocop")

-- ESLint LSP for real-time diagnostics (like VS Code)
vim.lsp.enable("eslint")

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

    -- TypeScript/JavaScript: Add missing imports + organize imports
    if client and client.name == "tsgo" then
      -- Keymap to manually organize imports
      keymap("n", "<leader>oi", function()
        vim.lsp.buf.code_action({
          apply = true,
          context = { only = { "source.organizeImports.ts" }, diagnostics = {} },
        })
      end, opts("Organize imports"))

      -- Keymap to add missing imports
      keymap("n", "<leader>ai", function()
        vim.lsp.buf.code_action({
          apply = true,
          context = { only = { "source.addMissingImports.ts" }, diagnostics = {} },
        })
      end, opts("Add missing imports"))
    end

    keymap("n", "K", function()
      vim.lsp.buf.hover({ border = "single", max_height = 10, max_width = 90 })
    end, opts("Hover"))

    keymap("n", "gK", function()
      vim.lsp.buf.signature_help({ border = "single", max_height = 10, max_width = 90 })
    end, opts("Signature Help"))

    keymap("n", "grd", vim.lsp.buf.definition, opts("Go to definition"))
    keymap("n", "grD", vim.lsp.buf.declaration, opts("Go to declaration"))
    keymap("n", "gca", vim.lsp.buf.code_action, opts("Code Actions"))

    keymap("n", "<leader>th", function()
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
    end, opts("Toggle inlay hints"))

    keymap("n", "<leader>d", vim.diagnostic.open_float, opts("Open current diagnostic in float window"))
    keymap("n", "<leader>rs", function()
      vim.cmd(":LspRestart")
    end, opts("Restart LSP"))
  end,
})
