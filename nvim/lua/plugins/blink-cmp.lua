return {
  "saghen/blink.cmp",

  enabled = true,

  dependencies = {
    "rafamadriz/friendly-snippets",
    {
      "xzbdmw/colorful-menu.nvim",
      opts = {},
    },
    -- "giuxtaposition/blink-cmp-copilot",
  },

  version = "*",

  -- build = "cargo build --release",

  opts = {
    -- fuzzy = {
    --   sorts = { "sort_text" },
    -- },
    -- fuzzy = {
    -- sorts = { "sort_text" },
    -- use_frecency = false,
    -- use_proximity = false,
    -- max_typos = function()
    --   return 0
    -- end,
    -- Use the Rust implementation for better performance and sorting
    -- implementation = "prefer_rust_with_warning",
    -- sorts = {
    --   "exact", -- Exact matches first (VSCode behavior)
    --   "score", -- Then by fuzzy score
    --   "sort_text", -- Then by LSP sort preferences
    -- },
    -- sorts = {
    --   function(a, b)
    --     print(a, b)
    --
    --     local kind_priority = {
    --       [2] = 1, -- Method
    --       [3] = 2, -- Function
    --       [4] = 3, -- Constructor
    --       [5] = 4, -- Field
    --       [6] = 5, -- Variable
    --       [10] = 6, -- Property
    --     }
    --     local ak = kind_priority[a.kind or 100] or 100
    --     local bk = kind_priority[b.kind or 100] or 100
    --     if ak ~= bk then
    --       return ak < bk
    --     end
    --   end,
    --   --   "score",
    --   --   "sort_text",
    -- },
    -- },

    appearance = {
      use_nvim_cmp_as_default = false,
      nerd_font_variant = "mono",

      kind_icons = {
        Text = " ",
        Method = " ",
        Function = " ",
        Constructor = " ",
        Field = " ",
        Variable = " ",
        Class = " ",
        Interface = " ",
        Module = " ",
        -- Property = " ",
        Property = " ",
        Unit = " ",
        Value = " ",
        Enum = " ",
        Keyword = " ",
        Snippet = " ",
        Color = " ",
        File = " ",
        Reference = " ",
        Folder = " ",
        EnumMember = " ",
        Constant = " ",
        Struct = " ",
        Event = " ",
        Operator = " ",
        TypeParameter = " ",

        -- Method = "󰡱 ",
        -- Method = "󰆧 ",
        -- Function = "󰡱 ",
        -- Constructor = " ",
        -- Variable = "󰀫 ",
        -- Class = " ",
        -- Interface = " ",
        -- Module = " ",
        -- Unit = "󰑭 ",
        -- Value = "󰎠 ",
        -- Enum = " ",
        -- Snippet = " ",
        -- Color = "󰏘 ",
        -- File = "󰈙 ",
        -- Folder = "󰉋 ",
        -- EnumMember = " ",
        -- Constant = "󰏿 ",
        -- Struct = "󰙅 ",
        -- Event = " ",
        Array = " ",
        Boolean = "󰨙 ",
        Codeium = "󰘦 ",
        Control = " ",
        Collapsed = " ",
        Copilot = " ",
        Key = " ",
        -- Keyword = " ",
        Namespace = "󰦮 ",
        Null = " ",
        Number = "󰎠 ",
        Object = " ",
        Package = " ",
        -- Field = " ",
        -- Field = " ",
        -- Property = " ",
        -- Reference = " ",
        String = " ",
        Supermaven = " ",
        TabNine = "󰏚 ",
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
      completion = { menu = { auto_show = true }, ghost_text = { enabled = true } },

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
        -- min_width = 30,

        border = "single",

        scrollbar = false,
        draw = {
          -- padding = 1,
          -- gap = 0,
          -- columns = { { "kind_icon" }, { "label", gap = 0 } },
          -- treesitter = { "lsp" },
          -- components = {
          --   label = {
          --     text = function(ctx)
          --       return require("colorful-menu").blink_components_text(ctx)
          --     end,
          --     highlight = function(ctx)
          --       return require("colorful-menu").blink_components_highlight(ctx)
          --     end,
          --   },
          columns = { { "kind_icon" }, { "label", gap = 0 } },
          components = {
            label = {
              text = function(ctx)
                return require("colorful-menu").blink_components_text(ctx)
              end,
              highlight = function(ctx)
                return require("colorful-menu").blink_components_highlight(ctx)
              end,
            },
          },
        },
      },

      documentation = {
        auto_show = true,
        auto_show_delay_ms = 200,
        window = {
          border = "single",
          -- min_width = 50,
          -- max_width = 60,
          -- max_height = 20,
          scrollbar = false,
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

    -- signature = {
    --   enabled = true,
    --   window = {
    --     border = "single",
    --     show_documentation = false,
    --     min_width = 50,
    --     max_width = 60,
    --     max_height = 10,
    --     scrollbar = false,
    --   },
    -- },

    sources = {
      default = { "lazydev", "lsp", "path", "snippets" },
      -- default = { "lazydev", "lsp", "copilot", "path", "snippets", "buffer" },

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
        -- copilot = {
        --   name = "copilot",
        --   module = "blink-cmp-copilot",
        --   score_offset = 100,
        --   async = true,
        -- },
        path = {
          min_keyword_length = 0,
        },
        -- snippets = {
        --   min_keyword_length = 2,
        -- },
        -- buffer = {
        -- min_keyword_length = 2,
        -- max_items = 5,
        -- },
        -- },
      },
    },
  },

  opts_extend = { "sources.default" },
}
