return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local lint = require("lint")

    -- Linters by filetype
    -- Note: These tools natively search parent directories for configs
    -- rubocop: searches for .rubocop.yml up to root
    -- ruff: searches for ruff.toml/pyproject.toml up to root
    -- golangci-lint: searches for .golangci.yml up to root
    lint.linters_by_ft = {
      ruby = { "rubocop" },
      go = { "golangci_lint" },
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
