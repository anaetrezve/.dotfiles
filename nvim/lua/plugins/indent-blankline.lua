return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  opts = {
    -- indent = { char = "│" },
    -- indent = { char = "▏" },
    indent = {
      char = "▏",
    },
    scope = {
      include = {
        node_type = { ["*"] = { "*" } },
      },
      enabled = true,
      show_start = false,
      show_end = false,
      show_exact_scope = false,
      injected_languages = true,
    },
    exclude = { filetypes = { "help", "neo-tree", "dashboard" } },
  },
}
