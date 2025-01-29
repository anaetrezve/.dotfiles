return {
  "saghen/blink.cmp",

  dependencies = {
    "rafamadriz/friendly-snippets",
    {
      "xzbdmw/colorful-menu.nvim",

      config = function()
        require("colorful-menu").setup({})
      end,
    },
  },

  version = "*",

  config = function()
    require("blink.cmp").setup({
      keymap = {
        preset = "none",
        cmdline = {
          ["<CR>"] = { "fallback" },
          ["<C-k>"] = { "select_prev", "fallback" },
          ["<C-j>"] = { "select_next", "fallback" },
          ["<C-c>"] = { "show", "show_documentation", "hide_documentation" },
          ["<C-u>"] = { "scroll_documentation_up", "fallback" },
          ["<C-d>"] = { "scroll_documentation_down", "fallback" },
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

        ["<C-k>"] = { "select_prev", "fallback" },
        ["<C-j>"] = { "select_next", "fallback" },
        ["<C-c>"] = { "show", "show_documentation", "hide_documentation" },
        ["<C-u>"] = { "scroll_documentation_up", "fallback" },
        ["<C-d>"] = { "scroll_documentation_down", "fallback" },
        ["<CR>"] = {
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

      -- appearance = {
      --   use_nvim_cmp_as_default = true,
      --   nerd_font_variant = "mono",
      -- },

      -- sources = {
      --   default = { "lsp", "snippets", "path", "buffer" },
      -- },

      signature = { enabled = true },

      completion = {
        ghost_text = {
          enabled = true,
        },

        accept = { auto_brackets = { enabled = true } },

        menu = {
          draw = {
            treesitter = { "lsp" },
            columns = { { "kind_icon" }, { "label", "label_description", gap = 1 } },

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

  -- opts_extend = { "sources.default" },
}
