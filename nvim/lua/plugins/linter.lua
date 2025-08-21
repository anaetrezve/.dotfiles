return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local lint = require("lint")

    -- Linters mapped per filetype
    -- Note: ESLint auto-fixing on save is handled by conform.nvim
    -- This configuration is for linting feedback during editing
    lint.linters_by_ft = {
      -- JavaScript/TypeScript
      javascript = { "eslint" },
      typescript = { "eslint" },
      javascriptreact = { "eslint" },
      typescriptreact = { "eslint" },
      svelte = { "eslint" },
      -- Ruby
      ruby = { "rubocop" },
      -- Go
      go = { "golangci_lint" }, -- Requires `golangci-lint` installed
      -- Rust
      rust = { "clippy" },      -- Linter runs via cargo, ensure clippy is installed
      -- Python
      python = { "pylint" },    -- Or use "flake8", "ruff", etc.
    }

    local lint_augroup = vim.api.nvim_create_augroup("LintAutogroup", { clear = true })

    -- Lint with fallback to LSP diagnostics if no linter is configured
    local function lint_or_lsp()
      local bufnr = vim.api.nvim_get_current_buf()
      local ft = vim.bo.filetype
      local linter_configured = lint.linters_by_ft[ft] ~= nil

      if linter_configured then
        lint.try_lint()
      else
        vim.diagnostic.show(nil, bufnr)
      end
    end

    -- Auto-trigger on common buffer events (avoid BufWritePost since conform handles save)
    vim.api.nvim_create_autocmd({ "BufEnter", "InsertLeave", "TextChanged" }, {
      group = lint_augroup,
      callback = lint_or_lsp,
    })

    -- Manual lint command with LSP fallback
    vim.keymap.set("n", "<leader>l", function()
      local ft = vim.bo.filetype
      if lint.linters_by_ft[ft] then
        lint.try_lint()
      else
        vim.notify("No external linter for '" .. ft .. "', falling back to LSP diagnostics", vim.log.levels.INFO)
        vim.diagnostic.show(nil, 0)
      end
    end, { desc = "Lint current file or fallback to LSP" })
  end,
}
