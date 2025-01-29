return {
  "neovim/nvim-lspconfig",

  dependencies = { "saghen/blink.cmp" },

  opts = {
    servers = {
      lua_ls = {},
      pylsp = {},
      ts_ls = {},
      ruby_lsp = {},
      solargraph = {},
      jsonls = {},
      bashls = {},
    },
  },

  config = function(_, opts)
    local lspconfig = require("lspconfig")

    local signs = { Error = "󰅙", Info = "󰋼", Hint = "󰌵", Warn = "" }
    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
    end

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
