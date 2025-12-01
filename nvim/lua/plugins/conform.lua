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
        args = function(self, ctx)
          -- Check if project has a prettier config
          local config_file = vim.fs.find({
            ".prettierrc",
            ".prettierrc.json",
            ".prettierrc.yml",
            ".prettierrc.yaml",
            ".prettierrc.json5",
            ".prettierrc.js",
            ".prettierrc.cjs",
            ".prettierrc.mjs",
            "prettier.config.js",
            "prettier.config.cjs",
            "prettier.config.mjs",
          }, { path = ctx.filename, upward = true })[1]

          -- If no config found, use our default config
          if not config_file then
            local default_config = vim.fn.stdpath("config") .. "/../default-fallback-configs/prettier.config.js"
            return { "--config", default_config, "--stdin-filepath", "$FILENAME" }
          end

          -- Otherwise, let prettier find the config automatically
          return { "--stdin-filepath", "$FILENAME" }
        end,
        stdin = true,
      },
      eslint_fix = {
        command = "eslint",
        args = function(self, ctx)
          -- Check if project has an eslint config
          local config_file = vim.fs.find({
            "eslint.config.js",
            "eslint.config.mjs",
            "eslint.config.cjs",
            ".eslintrc.js",
            ".eslintrc.cjs",
            ".eslintrc.json",
            ".eslintrc",
          }, { path = ctx.filename, upward = true })[1]

          -- If no config found, use our default config
          if not config_file then
            local default_config = vim.fn.stdpath("config") .. "/../default-fallback-configs/eslint.config.js"
            return { "--config", default_config, "--fix", "$FILENAME" }
          end

          -- Otherwise, let eslint find the config automatically
          return { "--fix", "$FILENAME" }
        end,
        stdin = true,
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
      elseif
        ft == "javascript"
        or ft == "typescript"
        or ft == "javascriptreact"
        or ft == "typescriptreact"
        or ft == "svelte"
      then
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
