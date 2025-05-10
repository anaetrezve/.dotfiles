return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },

  opts = {
    default_format_opts = {
      lsp_format = "fallback",
    },

    notify_on_error = true,
    notify_no_formatters = true,

    formatters_by_ft = {
      javascript = { "prettier", "prettierd", stop_after_first = true },
      typescript = { "prettier", "prettierd", stop_after_first = true },
      javascriptreact = { "prettier", "prettierd", stop_after_first = true },
      typescriptreact = { "prettier", "prettierd", stop_after_first = true },
      svelte = { "prettier", "prettierd", stop_after_first = true },
      css = { "prettier", "prettierd", stop_after_first = true },
      html = { "prettier", "prettierd", stop_after_first = true },
      json = { "prettier", "prettierd", stop_after_first = true },
      yaml = { "prettier", "prettierd", stop_after_first = true },
      markdown = { "prettier", "prettierd", stop_after_first = true },
      graphql = { "prettier", "prettierd", stop_after_first = true },
      lua = { "stylua", stop_after_first = true },
      ruby = { "rubocop", stop_after_first = true },
    },

    format_on_save = {
      async = false,
      -- timeout_ms = 500,
      lsp_format = "fallback",
    },
  },

  config = function(_, opts)
    local conform = require("conform")

    conform.setup(opts)

    vim.keymap.set({ "n", "v" }, "<leader>f", function()
      conform.format({
        lsp_fallback = true,
        async = false,
        -- timeout_ms = 500,
      })
    end, { desc = "Format file or range (in visual mode)" })
  end,
}
