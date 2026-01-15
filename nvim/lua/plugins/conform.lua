-- Search upward for config file, stopping at $HOME
local function find_config(filename, config_names)
  local home = vim.env.HOME
  return vim.fs.find(config_names, {
    path = vim.fn.fnamemodify(filename, ":p:h"),
    upward = true,
    stop = home,
  })[1]
end

-- ESLint config file patterns
local eslint_configs = {
  "eslint.config.js",
  "eslint.config.mjs",
  "eslint.config.cjs",
  ".eslintrc",
  ".eslintrc.js",
  ".eslintrc.cjs",
  ".eslintrc.json",
  ".eslintrc.yml",
  ".eslintrc.yaml",
}

return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile", "BufWritePre" },

  opts = {
    default_format_opts = {
      lsp_format = "fallback",
    },

    notify_on_error = true,
    notify_no_formatters = false,

    -- Custom formatter configs
    formatters = {
      -- Prettier 4.x removed --stdin-filepath, use --write mode
      prettier = {
        args = { "--write", "$FILENAME" },
        stdin = false,
        -- inherit command detection from default (finds node_modules/.bin/prettier)
      },
    },

    formatters_by_ft = {
      -- JS/TS: eslint_d only if config exists (search up to $HOME), then prettier
      javascript = function(bufnr)
        local filename = vim.api.nvim_buf_get_name(bufnr)
        if find_config(filename, eslint_configs) then
          return { "eslint_d", "prettier" }
        end
        return { "prettier" }
      end,
      typescript = function(bufnr)
        local filename = vim.api.nvim_buf_get_name(bufnr)
        if find_config(filename, eslint_configs) then
          return { "eslint_d", "prettier" }
        end
        return { "prettier" }
      end,
      javascriptreact = function(bufnr)
        local filename = vim.api.nvim_buf_get_name(bufnr)
        if find_config(filename, eslint_configs) then
          return { "eslint_d", "prettier" }
        end
        return { "prettier" }
      end,
      typescriptreact = function(bufnr)
        local filename = vim.api.nvim_buf_get_name(bufnr)
        if find_config(filename, eslint_configs) then
          return { "eslint_d", "prettier" }
        end
        return { "prettier" }
      end,
      svelte = function(bufnr)
        local filename = vim.api.nvim_buf_get_name(bufnr)
        if find_config(filename, eslint_configs) then
          return { "eslint_d", "prettier" }
        end
        return { "prettier" }
      end,
      css = { "prettier" },
      html = { "prettier" },
      json = { "prettier" },
      yaml = { "prettier" },
      markdown = { "prettier" },
      graphql = { "prettier" },
      lua = { "stylua" },
      ruby = { "rubocop" },
      python = { "isort", "black" }, -- isort for imports, then black for formatting
      go = { "goimports", "gofumpt" },
      rust = { "rustfmt", lsp_format = "fallback" },
    },

    format_on_save = function(bufnr)
      local ft = vim.bo[bufnr].filetype
      if ft == "ruby" then
        return { timeout_ms = 3000, lsp_format = "fallback", async = false }
      elseif
          ft == "javascript"
          or ft == "typescript"
          or ft == "javascriptreact"
          or ft == "typescriptreact"
          or ft == "svelte"
      then
        -- Longer timeout for eslint_d + prettier
        return { timeout_ms = 2000, lsp_format = "fallback", async = false }
      end
      return { timeout_ms = 1000, lsp_format = "fallback", async = false }
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
