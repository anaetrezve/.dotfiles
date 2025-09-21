return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile", "BufWritePre" },

  opts = {
    default_format_opts = {
      lsp_format = "fallback",
    },

    notify_on_error = true,
    notify_no_formatters = true,

    -- Explicit formatter configurations to ensure compatibility
    formatters = {
      prettier = {
        command = "prettier",
        args = { "--stdin-filepath", "$FILENAME" },
        stdin = true,
      },
      eslint_fix = {
        command = "eslint",
        args = { "--fix", "$FILENAME" },
        stdin = false,
        exit_codes = { 0, 1 },
      },
    },

    formatters_by_ft = {
      javascript = { "eslint_fix", "prettier" },
      typescript = { "eslint_fix", "prettier" },
      javascriptreact = { "eslint_fix", "prettier" },
      typescriptreact = { "eslint_fix", "prettier" },
      svelte = { "eslint_fix", "prettier" },
      css = { "prettier" },
      html = { "prettier" },
      json = { "prettier" },
      yaml = { "prettier" },
      markdown = { "prettier" },
      graphql = { "prettier" },
      lua = { "stylua", stop_after_first = true },
      ruby = { "rubocop", stop_after_first = true },
      python = { "isort", "black", stop_after_first = true },
      go = { "goimports", "gofumpt" },
      rust = { "rustfmt", lsp_format = "fallback" },
    },

    -- format_on_save = {
    --   async = false,
    --   -- timeout_ms = 500,
    --   lsp_format = "fallback",
    -- },
    format_on_save = function(bufnr)
      local ft = vim.bo[bufnr].filetype
      if ft == "ruby" then
        return { timeout_ms = 3000, lsp_fallback = true, async = false }
      elseif ft == "javascript" or ft == "typescript" or ft == "javascriptreact" or ft == "typescriptreact" or ft == "svelte" then
        -- Longer timeout for ESLint fix + prettier
        return { timeout_ms = 2000, lsp_fallback = true, async = false }
      end
      return { timeout_ms = 1000, lsp_fallback = true, async = false }
    end,
  },

  config = function(_, opts)
    local conform = require("conform")

    conform.setup(opts)

    vim.keymap.set({ "n", "v" }, "<leader>ft", function()
      conform.format({
        lsp_fallback = true,
        async = false,
        -- timeout_ms = 500,
      })
    end, { desc = "Format file or range (in visual mode)" })
  end,
}
