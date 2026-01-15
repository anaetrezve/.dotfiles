return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile", "BufWritePre" },

  opts = {
    default_format_opts = {
      lsp_format = "fallback",
    },

    notify_on_error = true,
    notify_no_formatters = false,

    formatters = {
      -- Prettier 4.x removed --stdin-filepath, use --write mode instead
      prettier = {
        stdin = false,
        args = { "--write", "$FILENAME" },
      },
    },

    formatters_by_ft = {
      -- JS/TS: eslint_d (fast daemon) for fixes, then prettier for formatting
      javascript = { "eslint_d", "prettier" },
      typescript = { "eslint_d", "prettier" },
      javascriptreact = { "eslint_d", "prettier" },
      typescriptreact = { "eslint_d", "prettier" },
      svelte = { "eslint_d", "prettier" },
      css = { "prettier" },
      html = { "prettier" },
      json = { "prettier" },
      yaml = { "prettier" },
      markdown = { "prettier" },
      graphql = { "prettier" },
      lua = { "stylua" },
      ruby = { "rubocop" },
      python = { "isort", "black" },
      go = { "goimports", "gofumpt" },
      rust = { "rustfmt", lsp_format = "fallback" },
    },

    format_on_save = function(bufnr)
      local ft = vim.bo[bufnr].filetype
      if ft == "ruby" then
        return { timeout_ms = 3000, lsp_format = "fallback", async = false }
      end
      -- 2000ms for large monorepos, eslint_d is still faster than LSP
      return { timeout_ms = 2000, lsp_format = "fallback", async = false }
    end,
  },

  config = function(_, opts)
    local conform = require("conform")
    conform.setup(opts)

    vim.keymap.set({ "n", "v" }, "<leader>ft", function()
      conform.format({
        lsp_format = "fallback",
        async = false,
        timeout_ms = 2000,
      })
    end, { desc = "Format file or range (in visual mode)" })
  end,
}
