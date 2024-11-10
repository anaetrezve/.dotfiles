-- Servernames added from https://github.com/williamboman/mason-lspconfig.nvim?tab=readme-ov-file#available-lsp-servers
local servers = {
  "lua_ls",
  "bashls",
  "cssls",
  "cssmodules_ls",
  "css_variables",
  "dockerls",
  "docker_compose_language_service",
  "eslint",
  "emmet_language_server",
  "gopls",
  "graphql",
  "html",
  "jsonls",
  "ts_ls",
  "remark_ls", -- Markdown
  "pylsp",
  "rust_analyzer",
  "sqlls",
  "stylelint_lsp",
  "taplo",
  "tailwindcss",
  "terraformls",
  "yamlls",
}

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
      ensure_installed = servers,
    },
    config = function(_, opts)
      require("mason-lspconfig").setup(opts)
    end,
  },
  {
    "j-hui/fidget.nvim",
    config = true,
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = { "hrsh7th/cmp-nvim-lsp", "hrsh7th/nvim-cmp" },
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

      -- local lspconfig = require("lspconfig")
      -- -- local navic = require("nvim-navic")
      --
      -- -- Add additional capabilities supported by nvim-cmp
      -- local capabilities = vim.lsp.protocol.make_client_capabilities()
      -- capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())
      --
      -- local keymap = vim.keymap -- for conciseness
      --
      -- vim.api.nvim_create_autocmd("LspAttach", {
      --   group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
      --   callback = function(ev)
      --     vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
      --       max_width = 80,
      --       max_height = 12,
      --     })
      --     vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
      --       max_width = 80,
      --       max_height = 12,
      --     })
      --     -- Buffer local mappings.
      --     -- See `:help vim.lsp.*` for documentation on any of the below functions
      --     local opts = function(desc)
      --       return { buffer = ev.buf, silent = true, desc = desc }
      --     end
      --
      --     -- set keybinds
      --     keymap.set("n", "gd", vim.lsp.buf.definition, opts("Goto Definition"))
      --     keymap.set("n", "gr", vim.lsp.buf.references, opts("References"))
      --     keymap.set("n", "gi", vim.lsp.buf.implementation, opts("Goto Implementation"))
      --     keymap.set("n", "gt", vim.lsp.buf.type_definition, opts("Goto Type Definition"))
      --     keymap.set("n", "gD", vim.lsp.buf.declaration, opts("Goto Declaration"))
      --     keymap.set("n", "K", vim.lsp.buf.hover, opts("Show documentation for what is under cursor"))
      --     keymap.set("n", "gK", vim.lsp.buf.signature_help, opts("Signature Help"))
      --     keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, opts("Signature Help"))
      --     keymap.set("n", "gf", vim.lsp.buf.format, opts("LSP Formating"))
      --     keymap.set("n", "ca", vim.lsp.buf.code_action, opts("LSP Code Action"))
      --     keymap.set("n", "]]", vim.diagnostic.goto_next, opts("Goto Previous Diagnostic"))
      --     keymap.set("n", "[[", vim.diagnostic.goto_prev, opts("Goto Next Diagnostic"))
      --     keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts("LSP Rename"))
      --     keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts("Restart LSP"))
      --
      --     -- keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts("Show LSP references")) -- show definition, references
      --     -- keymap.set("n", "gD", vim.lsp.buf.declaration, opts("Go to declaration")) -- go to declaration
      --     -- keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts("Show LSP definitions")) -- show lsp definitions
      --     -- keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts("Show LSP implementations")) -- show lsp implementations
      --     -- keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts("Show LSP type definitions")) -- show lsp type definitions
      --     -- keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts("See available code actions")) -- see available code actions, in visual mode will apply to selection
      --     -- keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts("Smart rename")) -- smart rename
      --     -- keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts("Show buffer diagnostics")) -- show  diagnostics for file
      --     -- keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts("Show line diagnostics")) -- show diagnostics for line
      --     -- keymap.set("n", "[d", vim.diagnostic.goto_prev, opts("Go to previous diagnostic")) -- jump to previous diagnostic in buffer
      --     -- keymap.set("n", "]d", vim.diagnostic.goto_next, opts("Go to next diagnostic")) -- jump to next diagnostic in buffer
      --     -- keymap.set("n", "K", vim.lsp.buf.hover, opts("Show documentation for what is under cursor")) -- show documentation for what is under cursor
      --     -- keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts("Restart LSP")) -- mapping to restart lsp if necessary
      --
      --     -- Get client
      --     -- local client = vim.lsp.get_client_by_id(ev.data.client_id)
      --     --
      --     -- if client.server_capabilities.documentSymbolProvider then
      --     --   vim.o.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"
      --     --   navic.attach(client, ev.buf)
      --     -- end
      --   end,
      -- })
      --
      -- -- local signs = { Error = " ", Warn = " ", Hint = "󰌶 ", Info = " " }
      -- local signs = { Error = "󰅙", Info = "󰋼", Hint = "󰌵", Warn = "" }
      -- for type, icon in pairs(signs) do
      --   local hl = "DiagnosticSign" .. type
      --   vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
      -- end
      --
      -- vim.diagnostic.config({
      --   virtual_text = {
      --     prefix = "",
      --   },
      --   signs = true,
      --   underline = true,
      --   update_in_insert = false,
      --
      --   -- float = {
      --   --   border = "single",
      --   -- },
      -- })
      --
      -- -- To instead override globally
      -- -- local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
      -- -- function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
      -- --   opts = opts or {}
      -- --   opts.width = 80
      -- --   opts.height = 30
      -- --   opts.max_width = 100
      -- --   opts.max_height = 30
      -- --   return orig_util_open_floating_preview(contents, syntax, opts, ...)
      -- -- end
      --
      -- -- lsps with default config
      -- for _, lsp in ipairs(servers) do
      --   lspconfig[lsp].setup({
      --     -- on_attach = on_attach,
      --     -- on_init = on_init,
      --     capabilities = capabilities,
      --   })
      -- end
      --
      -- lspconfig["ruby_lsp"].setup({
      --   capabilities = capabilities,
      --   init_options = {
      --     formatter = "standard",
      --     linters = { "standard" },
      --   },
      -- })
    end,
  },
}