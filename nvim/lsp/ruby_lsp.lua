return {
  cmd = { "ruby-lsp" },
  filetypes = { "ruby", "eruby" },
  root_markers = { "Gemfile", ".git" },
  init_options = {
    formatter = "auto",
    enabledFeatures = {
      hover = true,
      diagnostics = true,
      completion = true,
    },
  },
}
