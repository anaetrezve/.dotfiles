-- Servernames added from https://github.com/williamboman/mason-lspconfig.nvim?tab=readme-ov-file#available-lsp-servers
local function get_ruby_lsp_path()
  local handle = io.popen("rbenv which ruby-lsp")
  local result = handle:read("*a")
  handle:close()
  return result:gsub("%s+", "")
end

local function get_solargraph_path()
  local handle = io.popen("rbenv which solargraph")
  local result = handle:read("*a")
  handle:close()
  return result:gsub("%s+", "")
end

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
  --   cmd = { get_ruby_lsp_path(), "stdio" },
  -- settings = {
  --   ruby_lsp = {
  --     diagnostics = true,
  --   },
  -- },
  -- },

  -- solargraph = {
  -- cmd = { get_solargraph_path(), "stdio" },
  --   settings = {
  --     solargraph = {
  --       diagnostics = true,
  --     },
  --   },
  -- },

  jsonls = {},

  bashls = {},
}
