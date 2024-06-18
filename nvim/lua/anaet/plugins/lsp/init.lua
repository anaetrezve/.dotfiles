local keymap = vim.keymap.set

local check_triggeredChars = function(triggerChars)
  local cur_line = vim.api.nvim_get_current_line()
  local pos = vim.api.nvim_win_get_cursor(0)[2]

  cur_line = cur_line:gsub("%s+$", "") -- rm trailing spaces

  for _, char in ipairs(triggerChars) do
    if cur_line:sub(pos, pos) == char then
      return true
    end
  end
end

local signature_setup = function(client, bufnr)
  local group = vim.api.nvim_create_augroup("LspSignature", { clear = false })
  vim.api.nvim_clear_autocmds({ group = group, buffer = bufnr })

  local triggerChars = client.server_capabilities.signatureHelpProvider.triggerCharacters

  vim.api.nvim_create_autocmd("TextChangedI", {
    group = group,
    buffer = bufnr,
    callback = function()
      if check_triggeredChars(triggerChars) then
        vim.lsp.buf.signature_help()
      end
    end,
  })
end

local function apply(curr, win)
  local newName = vim.trim(vim.fn.getline("."))
  vim.api.nvim_win_close(win, true)

  if #newName > 0 and newName ~= curr then
    local params = vim.lsp.util.make_position_params()
    params.newName = newName

    vim.lsp.buf_request(0, "textDocument/rename", params)
  end
end

local renamer = function()
  local currName = vim.fn.expand("<cword>") .. " "

  local win = require("plenary.popup").create(currName, {
    title = "Renamer",
    style = "minimal",
    borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
    relative = "cursor",
    borderhighlight = "RenamerBorder",
    titlehighlight = "RenamerTitle",
    focusable = true,
    width = 25,
    height = 1,
    line = "cursor+2",
    col = "cursor-1",
  })

  vim.cmd("normal A")
  vim.cmd("startinsert")

  keymap({ "i", "n" }, "<Esc>", "<cmd>q<CR>", { buffer = 0 })

  keymap({ "i", "n" }, "<CR>", function()
    apply(currName, win)
    vim.cmd.stopinsert()
  end, { buffer = 0 })
end

-- export on_attach & capabilities
local on_attach = function(client, bufnr)
  local function opts(desc)
    return { buffer = bufnr, desc = "LSP " .. desc }
  end

  keymap("n", "gD", vim.lsp.buf.declaration, opts("Go to declaration"))
  keymap("n", "gd", vim.lsp.buf.definition, opts("Go to definition"))
  keymap("n", "gi", vim.lsp.buf.implementation, opts("Go to implementation"))
  keymap("n", "<leader>sh", vim.lsp.buf.signature_help, opts("Show signature help"))
  keymap("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts("Add workspace folder"))
  keymap("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts("Remove workspace folder"))

  keymap("n", "<leader>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, opts("List workspace folders"))

  keymap("n", "<leader>D", vim.lsp.buf.type_definition, opts("Go to type definition"))

  keymap("n", "<leader>ra", function()
    renamer()
  end, opts("Renamer"))

  keymap({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts("Code action"))
  keymap("n", "gr", vim.lsp.buf.references, opts("Show references"))

  -- -- setup signature popup
  if signature_setup and client.server_capabilities.signatureHelpProvider then
    signature_setup(client, bufnr)
  end
end

-- disable semanticTokens
local on_init = function(client, _)
  if client.supports_method("textDocument/semanticTokens") then
    client.server_capabilities.semanticTokensProvider = nil
  end
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem = {
  documentationFormat = { "markdown", "plaintext" },
  snippetSupport = true,
  preselectSupport = true,
  insertReplaceSupport = true,
  labelDetailsSupport = true,
  deprecatedSupport = true,
  commitCharactersSupport = true,
  tagSupport = { valueSet = { 1 } },
  resolveSupport = {
    properties = {
      "documentation",
      "detail",
      "additionalTextEdits",
    },
  },
}

local function lspSymbol(name, icon)
  local hl = "DiagnosticSign" .. name
  vim.fn.sign_define(hl, { text = icon, numhl = hl, texthl = hl })
end

return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },

  config = function()
    local lspconfig = require("lspconfig")
    local servers = { "html" }

    --  LspInfo window borders
    local win = require("lspconfig.ui.windows")
    local _default_opts = win.default_opts

    win.default_opts = function(options)
      local opts = _default_opts(options)
      opts.border = "single"
      return opts
    end

    lspSymbol("Error", "󰅙")
    lspSymbol("Info", "󰋼")
    lspSymbol("Hint", "󰌵")
    lspSymbol("Warn", "")

    vim.diagnostic.config({
      virtual_text = {
        prefix = "",
      },
      signs = true,
      underline = true,
      -- update_in_insert = false,

      float = {
        border = "single",
      },
    })

    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
      border = "single",
    })

    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
      border = "single",
      focusable = false,
      relative = "cursor",
      silent = true,
    })

    -- lsps with default config
    for _, lsp in ipairs(servers) do
      lspconfig[lsp].setup({
        on_attach = on_attach,
        on_init = on_init,
        capabilities = capabilities,
      })
    end

    lspconfig.lua_ls.setup({
      on_attach = on_attach,
      capabilities = capabilities,
      on_init = on_init,

      settings = {
        Lua = {
          diagnostics = {
            globals = { "vim" },
          },
          workspace = {
            library = {
              vim.fn.expand("$VIMRUNTIME/lua"),
              vim.fn.expand("$VIMRUNTIME/lua/vim/lsp"),
              vim.fn.stdpath("data") .. "/lazy/ui/nvchad_types",
              vim.fn.stdpath("data") .. "/lazy/lazy.nvim/lua/lazy",
            },
            maxPreload = 100000,
            preloadFileSize = 10000,
          },
        },
      },
    })
  end,
}
