return {
  "folke/noice.nvim",
  event = "VeryLazy",
  opts = {
    cmdline = {
      format = {
        search_replace = { kind = "search", pattern = "^:%%s/", icon = "󰛔", lang = "regex" },
      },
    },
    messages = {
      view_history = "popup",
    },
    commands = {
      history = {
        view = "popup",
      },
    },
    lsp = {
      hover = {
        enabled = true,
        opts = {
          scrollbar = false,
          zindex = 100,
          size = {
            max_width = 90,
            max_height = 12,
          },
        },
      },
      progress = {
        enabled = false,
      },
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
      },
      signature = {
        enabled = true,
        opts = {
          scrollbar = false,
          zindex = 100,
          size = {
            max_width = 90,
            max_height = 12,
          },
        },
        auto_open = {
          enabled = true,
          trigger = true, -- Automatically show signature help when typing a trigger character from the LSP
          throttle = 50, -- Debounce lsp signature help request by 50ms
        },
      },
      documentation = {
        view = "hover",
      },
    },
    presets = {
      inc_rename = true,
      lsp_doc_border = true,
    },
    views = {
      cmdline_popup = {
        position = {
          row = "50%",
          col = "50%",
        },

        -- border = {
        --   style = "single",
        --   padding = { 1, 1 },
        -- },
        -- filter_options = {},
        -- win_options = {
        --   winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
        -- },
      },
      popup = {
        size = {
          width = "80%",
          height = "50%",
        },
        border = {
          style = "single",
        },
        win_options = {
          wrap = true,
        },
      },
    },
    routes = {
      -- SEND MESSAGES TO MINI
      {
        view = "mini",
        filter = {
          event = "msg_show",
          any = {
            { find = "; after #%d+" },
            { find = "; before #%d+" },
            { find = "fewer lines" },
            { find = "written" },
          },
        },
      },
      {
        view = "mini",
        filter = {
          event = "notify",
          any = {
            { find = "hidden" },
            { find = "clipboard" },
            { find = "Deleted" },
            { find = "Renamed" },
            { find = "file_browser" },
          },
        },
      },
      -- SKIP MESSAGES
      {
        filter = {
          event = "msg_show",
          kind = "",
          any = {
            { find = "catalog" },
          },
        },
        opts = { skip = true },
      },
      -- {
      --     filter = {
      --         event = 'notify',
      --         kind = 'info',
      --         any = {
      --             { find = 'hidden' },
      --         },
      --     },
      --     opts = { skip = true },
      -- },
    },
  },
}
