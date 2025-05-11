return {
  "stevearc/conform.nvim",

  event = { "BufReadPre", "BufNewFile" },

  opts = {
    default_format_opts = {
      lsp_format = "fallback",
      timeout_ms = 1000,
    },

    notify_on_error = true,
    notify_no_formatters = true,

    formatters_by_ft = {
      javascript = { "prettierd", "prettier", stop_after_first = true },
      typescript = { "prettierd", "prettier", stop_after_first = true },
      javascriptreact = { "prettierd", "prettier", stop_after_first = true },
      typescriptreact = { "prettierd", "prettier", stop_after_first = true },
      svelte = { "prettierd", "prettier", stop_after_first = true },
      css = { "prettierd", "prettier", stop_after_first = true },
      html = { "prettierd", "prettier", stop_after_first = true },
      json = { "prettierd", "prettier", stop_after_first = true },
      yaml = { "prettierd", "prettier", stop_after_first = true },
      markdown = { "prettierd", "prettier", stop_after_first = true },
      graphql = { "prettierd", "prettier", stop_after_first = true },
      lua = { "stylua", stop_after_first = true },
      ruby = { "rubocop", stop_after_first = true },
      python = { "black", "isort", stop_after_first = true },
      sh = { "shfmt", stop_after_first = true },
      zsh = { "shfmt", stop_after_first = true },
      bash = { "shfmt", stop_after_first = true },
      toml = { "taplo", stop_after_first = true },
      rust = { "rustfmt", stop_after_first = true },
      go = { "gofmt", "goimports", stop_after_first = true },
    },

    format_on_save = {
      async = false,
      timeout_ms = 1000,
      lsp_format = "fallback",
    },

    -- Prettier configuration
    -- formatters = {
    --   prettier = {
    --     prepend_args = {
    --       "--single-quote",
    --       "--trailing-comma=es5",
    --       "--print-width=100",
    --     },
    --   },
    --   prettierd = {
    --     prepend_args = {
    --       "--single-quote",
    --       "--trailing-comma=es5",
    --       "--print-width=100",
    --     },
    --   },
    -- },
  },

  config = function(_, opts)
    local conform = require("conform")

    conform.setup(opts)

    -- Format on save
    vim.api.nvim_create_autocmd("BufWritePre", {
      pattern = "*",
      callback = function(args)
        conform.format({
          bufnr = args.buf,
          lsp_fallback = true,
          async = false,
          timeout_ms = 1000,
        })
      end,
    })

    vim.keymap.set({ "n", "v" }, "<leader>f", function()
      conform.format({
        lsp_fallback = true,
        async = false,
        timeout_ms = 1000,
      })
    end, { desc = "Format file or range (in visual mode)" })
  end,
}
