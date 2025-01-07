-- Servernames added from https://github.com/williamboman/mason-lspconfig.nvim?tab=readme-ov-file#available-lsp-servers

return {
  {
    "williamboman/mason.nvim",
    opts = {
      ui = {
        icons = {
          package_installed = " ",
          package_pending = " ",
          package_uninstalled = " ",
        },
        border = "single",
      },
    },
    config = function(_, opts)
      require("mason").setup(opts)
    end,
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = {
      ensure_installed = {
        "prettier", -- prettier formatter
        "prettierd",
        "stylua", -- lua formatter
        "eslint_d", -- js/ts linter
      },
    },
    config = function(_, opts)
      require("mason-tool-installer").setup(opts)
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      ensure_installed = require("plugins.lsp.servers"),
    },
    config = function(_, opts)
      require("mason-lspconfig").setup(opts)
    end,
  },
  -- {
  --   "j-hui/fidget.nvim",
  --   config = true,
  -- },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "saghen/blink.cmp",
      -- "hrsh7th/cmp-nvim-lsp", "hrsh7th/nvim-cmp"
    },
    lazy = false,
    config = function()
      require("plugins.lsp.lspconfig").defaults()

      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          vim.schedule(function()
            local client = vim.lsp.get_client_by_id(args.data.client_id)

            if client then
              local signatureProvider = client.server_capabilities.signatureHelpProvider
              if signatureProvider and signatureProvider.triggerCharacters then
                require("plugins.lsp.signature").setup(client, args.buf)
              end
            end
          end)
        end,
      })
    end,
  },
}
