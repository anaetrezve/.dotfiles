-- Servernames added from https://github.com/williamboman/mason-lspconfig.nvim?tab=readme-ov-file#available-lsp-servers

return {
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

  gopls = {},

  -- ruby_lsp = {
  -- cmd_env = { BUNDLE_GEMFILE = vim.fn.getenv("GLOBAL_GEMFILE") },
  -- cmd = { "ruby-lsp" },
  -- filetypes = { "ruby", "eruby" },
  -- root_dir = function()
  --   return vim.loop.cwd()
  -- end,
  -- },

  solargraph = {
    -- filetypes = { 'ruby' },
    -- settings = {
    --   solargraph = {
    --     commandPath = { os.getenv("HOME") .. "/.rbenv/shims/solargraph", "stdio" },
    --     autoformat = true,
    --     completion = true,
    --     diagnostic = true,
    --     folding = true,
    --     references = true,
    --     rename = true,
    --     symbols = true,
    --   },
    -- },
  },

  jsonls = {},

  bashls = {},
}
