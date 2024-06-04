return {
        'stevearc/conform.nvim',
        event = { 'BufReadPre', 'BufNewFile' },
        opts = {
            formatters_by_ft = {
                css = { 'prettier' },
                html = { 'prettier' },
                json = { 'prettier' },
                lua = { 'stylua' },
                markdown = { 'prettier' },
                rust = { 'rustfmt' },
                scss = { 'prettier' },
                vue = { 'prettier' },
        javascript = { "prettier" },
        typescript = { "prettier" },
        javascriptreact = { "prettier" },
        typescriptreact = { "prettier" },
        svelte = { "prettier" },
        yaml = { "prettier" },
        graphql = { "prettier" },
        python = { "isort", "black" },
            },
            format_on_save = {
                lsp_fallback = true,
                async = false,
                timeout_ms = 500,
            },
        },
        config = function(_, opts)
            local conform = require("conform");

            conform.setup(opts);
    vim.keymap.set({ "n", "v" }, "<leader>mp", function()
      conform.format({
        lsp_fallback = true,
        async = false,
        timeout_ms = 1000,
      })
    end, { desc = "Format file or range (in visual mode)" })
        end,
    }
