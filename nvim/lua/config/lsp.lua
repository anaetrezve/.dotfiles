vim.lsp.enable("lus_ls")

vim.lsp.config("*", {
  capabilities = require("blink.cmp").get_lsp_capabilities(),
})
