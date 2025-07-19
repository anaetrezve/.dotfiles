local utils = require("config.utils")

local keymap = vim.keymap.set

vim.lsp.config("*", {
  capabilities = require("blink.cmp").get_lsp_capabilities(),
})

-- getting all filenames from lsp directory
-- and extracting filenames without extension and enabling lsp
for _, v in ipairs(vim.api.nvim_get_runtime_file("lsp/*", true)) do
  vim.lsp.enable(vim.fn.fnamemodify(v, ":t:r"))
end

vim.diagnostic.config({
  virtual_text = {
    prefix = "▎", -- Could be '●', '▎', │, 'x', '■', , 
  },
  jump = {
    float = true,
  },
  float = { border = "single" },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = " ",
      [vim.diagnostic.severity.WARN] = " ",
      [vim.diagnostic.severity.HINT] = "󰌶 ",
      [vim.diagnostic.severity.INFO] = " ",
    },
    numhl = {
      [vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
      [vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
      [vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
      [vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
    },
  },
})

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
  callback = function(event)
    local function opts(desc)
      return { buffer = event.buf, desc = "LSP " .. desc }
    end

    -- Get client from event
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if not client then
      return
    end

    keymap("n", "K", function()
      local params = vim.lsp.util.make_position_params(0, "utf-8")
      vim.lsp.buf_request(0, "textDocument/hover", params, function(_, result)
        if not (result and result.contents) then
          return
        end

        local lines = vim.lsp.util.convert_input_to_markdown_lines(result.contents)
        lines = utils.normalize(lines)
        lines = utils.add_padding(lines, 1, 1, 1, 1)

        vim.lsp.util.open_floating_preview(lines, "markdown", {
          focusable = true,
          focus = true,
          border = "single",
          max_width = 90,
          zindex = 50,
          max_height = 10,
        })
      end)
    end, opts("Hover"))

    keymap("n", "gK", function()
      local params = vim.lsp.util.make_position_params(0, "utf-8")
      vim.lsp.buf_request(0, "textDocument/signatureHelp", params, function(_, result)
        if not (result and result.signatures and result.signatures[1]) then
          return
        end

        local lines = vim.lsp.util.convert_signature_help_to_markdown_lines(result)
        lines = utils.normalize(lines)
        lines = utils.add_padding(lines, 1, 1, 1, 1)

        vim.lsp.util.open_floating_preview(lines, "markdown", {
          focusable = true,
          focus = true,
          border = "single",
          max_width = 90,
          zindex = 50,
          max_height = 10,
        })
      end)
    end, opts("Signature Help"))
  end,
})
