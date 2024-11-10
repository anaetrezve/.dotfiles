local format_kk = require("plugins.cmp.format")
local icons = require("plugins.cmp.icons")
local cmp_ui = {
  icons_left = false, -- only for non-atom styles!
  format_colors = {
    tailwind = true, -- will work for css lsp too
  },
}

return {
  "hrsh7th/nvim-cmp",

  event = "InsertEnter",

  dependencies = {
    {
      -- snippet plugin
      "L3MON4D3/LuaSnip",
      dependencies = "rafamadriz/friendly-snippets",
      opts = { history = true, updateevents = "TextChanged,TextChangedI" },
      config = function(_, opts)
        require("luasnip").config.set_config(opts)
        require("plugins.cmp.snippet")
      end,
    },

    -- autopairing of (){}[] etc
    {
      "windwp/nvim-autopairs",
      opts = {
        fast_wrap = {},
        disable_filetype = { "TelescopePrompt", "vim", "neo-tree" },
      },
      config = function(_, opts)
        require("nvim-autopairs").setup(opts)

        -- setup cmp for autopairs
        local cmp_autopairs = require("nvim-autopairs.completion.cmp")
        require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
      end,
    },
    {
      "zbirenbaum/copilot-cmp",
      dependencies = "copilot.lua",
      opts = {},
      config = function(_, opts)
        local copilot_cmp = require("copilot_cmp")

        copilot_cmp.setup(opts)
      end,
    },
    -- cmp sources plugins
    {
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
    },
  },

  opts = function()
    local cmp = require("cmp")

    return {
      completion = { completeopt = "menu,menuone" },
      snippet = {
        expand = function(args)
          require("luasnip").lsp_expand(args.body)
        end,
      },

      formatting = {
        fields = { "kind", "abbr", "menu" },

        format = function(entry, item)
          item.abbr = item.abbr .. " "
          item.menu = item.kind or ""
          item.menu_hl_group = "CmpItemKind" .. (item.kind or "")
          item.kind = (icons[item.kind] or "") .. " "

          if not cmp_ui.icons_left then
            item.kind = " " .. item.kind
          end

          if cmp_ui.format_colors.tailwind then
            format_kk.tailwind(entry, item)
          end

          return item
        end,
      },

      window = {
        completion = {
          scrollbar = false,
          side_padding = 0,
          winhighlight = "Normal:CmpPmenu,CursorLine:CmpSel,Search:None,FloatBorder:CmpBorder",
          border = "single",
          max_height = 10,
        },

        documentation = {
          border = "single",
          winhighlight = "Normal:CmpDoc,FloatBorder:CmpDocBorder",
          max_height = 15,
        },
      },
      mapping = {
        ["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
        ["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion
        ["<C-u>"] = cmp.mapping.scroll_docs(-4),
        ["<C-d>"] = cmp.mapping.scroll_docs(4),
        ["<C-c>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.close(),

        ["<CR>"] = cmp.mapping.confirm({
          behavior = cmp.ConfirmBehavior.Insert,
          select = true,
        }),

        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif require("luasnip").expand_or_jumpable() then
            require("luasnip").expand_or_jump()
          else
            fallback()
          end
        end, { "i", "s" }),

        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif require("luasnip").jumpable(-1) then
            require("luasnip").jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
      },

      sources = {
        { name = "copilot", priority = 100, group_index = 1 },
        { name = "nvim_lsp", max_item_count = 8 },
        { name = "luasnip", max_item_count = 8 },
        { name = "nvim_lua", max_item_count = 8 },
        { name = "buffer", max_item_count = 5 },
        { name = "path", max_item_count = 5 },
      },
    }
  end,
}
