return {
  "neovim/nvim-lspconfig",

  dependencies = { "saghen/blink.cmp" },

  opts = function()
    -- local nvim_lsp = require("lspconfig")

    return {
      servers = {
        lua_ls = {
          settings = {
            Lua = {
              runtime = {
                version = "LuaJIT",
              },
              diagnostics = {
                globals = { "vim", "use", "winid" },
              },
            },
          },
        },
        pylsp = {},
        ts_ls = {},
        ruby_lsp = {
          -- cmd_env = { BUNDLE_GEMFILE = vim.fn.getenv("GLOBAL_GEMFILE") },
          -- cmd = { "ruby-lsp" },
          -- filetypes = { "ruby", "eruby" },
          -- root_dir = function()
          --   return vim.loop.cwd()
          -- end,
          cmd_env = { BUNDLE_GEMFILE = vim.fn.getenv("GLOBAL_GEMFILE") },
          cmd = { "ruby-lsp" },
          filetypes = { "ruby", "eruby" },
          root_dir = function()
            return vim.loop.cwd()
          end,
        },
        solargraph = {
          -- cmd = { os.getenv("HOME") .. "/.rbenv/shims/solargraph", "stdio" },
          -- root_dir = nvim_lsp.util.root_pattern("Gemfile", ".git", "."),
          settings = {
            solargraph = {
              commandPath = { os.getenv("HOME") .. "/.rbenv/shims/solargraph", "stdio" },
              autoformat = true,
              completion = true,
              diagnostic = true,
              folding = true,
              references = true,
              rename = true,
              symbols = true,
            },
          },
          -- cmd = {
          --   "asdf",
          --   "exec",
          --   "solargraph",
          --   "stdio",
          -- },
        },
        jsonls = {},
        bashls = {},
      },
    }
  end,

  config = function(_, opts)
    local lspconfig = require("lspconfig")

    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
      border = "single",
      focusable = false,
      silent = true,
      max_height = 8,
      max_width = 80,
    })
    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
      border = "single",
      focusable = false,
      silent = true,
      max_height = 8,
      max_width = 80,
    })

    local signs = { Error = " ", Warn = " ", Hint = "󰌶 ", Info = " " }
    -- local signs = { Error = "󰅙", Info = "󰋼", Hint = "󰌵", Warn = "" }
    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
    end

    -- vim.diagnostic.config({
    --   virtual_text = {
    --     prefix = "", -- Could be '●', '▎', │, 'x', '■', , 
    --   },
    --   jump = {
    --     float = true,
    --   },
    --   float = { border = "single" },
    --   signs = {
    --     text = {
    --       [vim.diagnostic.severity.ERROR] = " ",
    --       [vim.diagnostic.severity.WARN] = " ",
    --       [vim.diagnostic.severity.HINT] = "󰌶 ",
    --       [vim.diagnostic.severity.INFO] = " ",
    --     },
    --     numhl = {
    --       [vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
    --       [vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
    --       [vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
    --       [vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
    --     },
    --   },
    -- })

    for server, config in pairs(opts.servers) do
      config.capabilities = require("blink.cmp").get_lsp_capabilities(config.capabilities)
      config.on_attach = function(_, bufnr)
        local keymap = vim.keymap.set -- for conciseness
        local function options(desc)
          return { buffer = bufnr, desc = "LSP " .. desc }
        end

        keymap("n", "gd", vim.lsp.buf.definition, options("Goto Definition"))
        keymap("n", "gr", vim.lsp.buf.references, options("References"))
        keymap("n", "gi", vim.lsp.buf.implementation, options("Goto Implementation"))
        keymap("n", "gt", vim.lsp.buf.type_definition, options("Goto Type Definition"))
        keymap("n", "gD", vim.lsp.buf.declaration, options("Goto Declaration"))
        keymap("n", "K", vim.lsp.buf.hover, options("Show documentation for what is under cursor"))
        keymap("n", "gK", vim.lsp.buf.signature_help, options("Signature Help"))
        keymap("i", "<C-k>", vim.lsp.buf.signature_help, options("Signature Help"))
        keymap("n", "gf", vim.lsp.buf.format, options("Formating"))
        keymap("n", "ca", vim.lsp.buf.code_action, options("Code Action"))
        keymap("n", "]]", vim.diagnostic.goto_next, options("Goto Previous Diagnostic"))
        keymap("n", "[[", vim.diagnostic.goto_prev, options("Goto Next Diagnostic"))
        -- keymap("n", "<leader>rn", require("plugins.lsp.renamer"), opts("Rename"))
        keymap("n", "<leader>rs", ":LspRestart<CR>", options("Restart LSP"))
      end

      lspconfig[server].setup(config)
    end
  end,
}
