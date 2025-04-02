return {
  "saghen/blink.cmp",
  enabled = true,

  dependencies = "rafamadriz/friendly-snippets",
  version = "*",

  opts = {
    appearance = {
      use_nvim_cmp_as_default = false,
      nerd_font_variant = "mono",

      kind_icons = {
        Method = "󰆧 ",
        Function = "󰡱 ",
        Constructor = " ",
        Variable = "󰀫 ",
        Class = " ",
        Interface = " ",
        Module = " ",
        Unit = "󰑭 ",
        Value = "󰎠 ",
        Enum = " ",
        Snippet = " ",
        Color = "󰏘 ",
        File = "󰈙 ",
        Folder = "󰉋 ",
        EnumMember = " ",
        Constant = "󰏿 ",
        Struct = "󰙅 ",
        Event = " ",
        Array = " ",
        Boolean = "󰨙 ",
        Codeium = "󰘦 ",
        Control = " ",
        Collapsed = " ",
        Copilot = " ",
        Field = " ",
        Key = " ",
        Keyword = " ",
        Namespace = "󰦮 ",
        Null = " ",
        Number = "󰎠 ",
        Object = " ",
        Operator = " ",
        Package = " ",
        Property = " ",
        Reference = " ",
        String = " ",
        Supermaven = " ",
        TabNine = "󰏚 ",
        Text = " ",
        TypeParameter = " ",
      },
    },

    keymap = {
      preset = "none",
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
    },

    cmdline = {
      completion = { ghost_text = { enabled = true } },

      sources = function()
        local type = vim.fn.getcmdtype()
        -- Search forward and backward
        if type == "/" or type == "?" then
          return { "buffer" }
        end
        -- Commands
        if type == ":" then
          return { "cmdline" }
        end
        return {}
      end,

      keymap = {
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
    },

    completion = {
      menu = {
        border = "single",
        scrollbar = false,
        draw = {
          padding = 1,
          gap = 0,
          -- columns = { { "kind_icon" }, { "label", gap = 0 } },
          treesitter = { "lsp" },
          -- components = {
          --   label = {
          --     text = function(ctx)
          --       return require("colorful-menu").blink_components_text(ctx)
          --     end,
          --     highlight = function(ctx)
          --       return require("colorful-menu").blink_components_highlight(ctx)
          --     end,
          --   },
          -- },
        },
      },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 200,
        window = {
          border = "single",
        },
      },

      accept = {
        auto_brackets = {
          enabled = true,
        },
      },

      ghost_text = {
        enabled = true,
      },
    },

    signature = {
      enabled = true,
      window = {
        border = "single",
      },
    },

    sources = {
      default = { "lazydev", "lsp", "path", "snippets", "buffer" },

      providers = {
        lazydev = {
          name = "LazyDev",
          module = "lazydev.integrations.blink",
          score_offset = 100,
        },
        lsp = {
          min_keyword_length = 0,
          score_offset = 90,
        },
        path = {
          min_keyword_length = 0,
        },
        snippets = {
          min_keyword_length = 2,
        },
        buffer = {
          min_keyword_length = 2,
          max_items = 5,
        },
      },
    },
  },

  opts_extend = { "sources.default" },
}
