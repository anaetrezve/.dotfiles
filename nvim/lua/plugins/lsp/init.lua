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
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = function()
      local servers = require("plugins.lsp.servers")
      local linters_and_formatters = require("plugins.lsp.linters-formatters")

      return {
        ensure_installed = vim.tbl_extend("force", vim.tbl_keys(linters_and_formatters), vim.tbl_keys(servers)),
      }
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    opts = {},
  },
  -- {
  --   "j-hui/fidget.nvim",
  --   config = true,
  -- },
  {
    "neovim/nvim-lspconfig",
    dependencies = { "saghen/blink.cmp" },

    config = function()
      require("plugins.lsp.lspconfig").defaults()

      -- vim.api.nvim_create_autocmd("LspAttach", {
      --   callback = function(args)
      --     vim.schedule(function()
      --       local client = vim.lsp.get_client_by_id(args.data.client_id)
      --
      --       if client then
      --         local signatureProvider = client.server_capabilities.signatureHelpProvider
      --         if signatureProvider and signatureProvider.triggerCharacters then
      --           require("plugins.lsp.signature").setup(client, args.buf)
      --         end
      --       end
      --     end)
      --   end,
      -- })
    end,
  },
}
