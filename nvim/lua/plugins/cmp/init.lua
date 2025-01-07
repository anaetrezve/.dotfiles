return {
  "saghen/blink.cmp",

  dependencies = { "rafamadriz/friendly-snippets", "xzbdmw/colorful-menu.nvim" },

  version = "*",

  config = function()
    require("blink.cmp").setup({
      keymap = {
        preset = "default",
        ["<C-k>"] = { "select_prev", "fallback" },
        ["<C-j>"] = { "select_next", "fallback" },
        ["<C-c>"] = { "show", "show_documentation", "hide_documentation" },
        ["<C-u>"] = { "scroll_documentation_up", "fallback" },
        ["<C-d>"] = { "scroll_documentation_down", "fallback" },
        -- ["<CR>"] = { "accept", "fallback" },
        ["<Tab>"] = {
          function(cmp)
            if cmp.snippet_active() then
              return cmp.accept()
            else
              return cmp.select_and_accept()
            end
          end,
          "snippet_forward",
          "fallback",
        },
        ["<S-Tab>"] = { "snippet_backward", "fallback" },
      },

      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = "mono",
      },

      sources = {
        default = { "lsp", "snippets", "path", "buffer" },
      },
      completion = {
        ghost_text = {
          enabled = true,
        },
        menu = {
          draw = {
            -- treesitter = { "lsp" },
            columns = { { "kind_icon" }, { "label", "kind", gap = 1 } },

            components = {
              label = {
                text = require("colorful-menu").blink_components_text,
                highlight = require("colorful-menu").blink_components_highlight,
              },
            },
          },
        },
      },
    })
  end,

  opts_extend = { "sources.default" },
}
