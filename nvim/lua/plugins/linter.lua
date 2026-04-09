return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local lint = require("lint")

    -- Linters mapped per filetype
    -- Note: ESLint LSP handles JS/TS linting in real-time (like VS Code)
    -- nvim-lint is for languages without good LSP linting support
    lint.linters_by_ft = {
      -- JS/TS: handled by ESLint LSP (real-time, no need for nvim-lint)
      -- Ruby
      ruby = { "rubocop" },
      -- Go
      go = { "golangci_lint" },
      -- Python
      python = { "ruff" },
    }

    local lint_augroup = vim.api.nvim_create_augroup("LintAutogroup", { clear = true })

    -- Lint on file read and after save
    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
      group = lint_augroup,
      callback = function()
        -- Small delay to avoid issues with rapid events
        vim.defer_fn(function()
          if vim.api.nvim_buf_is_valid(0) then
            lint.try_lint()
          end
        end, 100)
      end,
    })

    -- Manual lint command
    vim.keymap.set("n", "<leader>l", function()
      lint.try_lint()
    end, { desc = "Lint current file" })
  end,
}
