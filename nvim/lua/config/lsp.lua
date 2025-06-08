vim.lsp.config("*", {
  -- capabilities = require("blink.cmp").get_lsp_capabilities(),
})

-- getting all filenames from lsp directory
-- and extracting filenames without extension and enabling lsp
for _, v in ipairs(vim.api.nvim_get_runtime_file("lsp/*", true)) do
  vim.lsp.enable(vim.fn.fnamemodify(v, ":t:r"))
end
