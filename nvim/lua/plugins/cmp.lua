local function border()
  return { "┌", "─", "┐", "│", "┘", "─", "└", "│" }

  -- return {
  --   { "┌", hl_name },
  --   { "─", hl_name },
  --   { "┐", hl_name },
  --   { "│", hl_name },
  --   { "┘", hl_name },
  --   { "─", hl_name },
  --   { "└", hl_name },
  --   { "│", hl_name },
  --
  --   -- { "╭", hl_name },
  --   -- { "─", hl_name },
  --   -- { "╮", hl_name },
  --   -- { "│", hl_name },
  --   -- { "╯", hl_name },
  --   -- { "─", hl_name },
  --   -- { "╰", hl_name },
  --   -- { "│", hl_name },
  -- }
end

local icons = {
  Namespace = "󰌗",
  Text = "󰉿",
  Method = "󰆧",
  Function = "󰆧",
  Constructor = "",
  Field = "󰜢",
  Variable = "󰀫",
  Class = "󰠱",
  Interface = "",
  Module = "",
  Property = "󰜢",
  Unit = "󰑭",
  Value = "󰎠",
  Enum = "",
  Keyword = "󰌋",
  Snippet = "",
  Color = "󰏘",
  File = "󰈚",
  Reference = "󰈇",
  Folder = "󰉋",
  EnumMember = "",
  Constant = "󰏿",
  Struct = "󰙅",
  Event = "",
  Operator = "󰆕",
  TypeParameter = "󰊄",
  Table = "",
  Object = "󰅩",
  Tag = "",
  Array = "[]",
  Boolean = "",
  Number = "",
  Null = "󰟢",
  String = "󰉿",
  Calendar = "",
  Watch = "󰥔",
  Package = "",
  Copilot = "",
  Codeium = "",
  TabNine = "",
}

return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "L3MON4D3/LuaSnip",
    "hrsh7th/cmp-buffer", -- source for text in buffer
    "hrsh7th/cmp-path", -- source for file system paths
    "saadparwaiz1/cmp_luasnip", -- for autocompletion
    "rafamadriz/friendly-snippets", -- useful snippets
    -- "onsails/lspkind.nvim", -- vs-code like pictograms
  },

  config = function()
    local cmp = require("cmp")
    -- local lspkind = require("lspkind")

    require("luasnip.loaders.from_vscode").lazy_load()

    cmp.setup({
      snippet = {
        expand = function(args)
          require("luasnip").lsp_expand(args.body)
        end,
      },

      completion = {
        completeopt = "menu,menuone",
      },

      -- configure lspkind for vs-code like pictograms in completion menu
      formatting = {
        fields = { "kind", "abbr", "menu" },
        format = function(_, item)
          local icon = icons[item.kind] or ""
          icon = " " .. icon .. " "
          item.kind = icon
          -- item.kind = string.format("%s %s", icon, item.kind or "")
          -- item.menu = ""
          -- item.menu = cmp_ui.lspkind_text and "   (" .. item.kind .. ")" or ""

          return item
        end,
      },

      window = {
        completion = {
          scrollbar = false,
          side_padding = 0,
          border = border(),
          winhighlight = "Normal:CmpMenu,FloatBorder:CmpMenuBorder,CursorLine:CmpSelectedLine,Search:None",
        },

        documentation = {
          -- border = false,
          border = border(),
          winhighlight = "Normal:CmpDoc,FloatBorder:CmpDocBorder,Search:None",
        },

        -- completion = cmp.config.window.bordered(),
        -- documentation = cmp.config.window.bordered(),
      },

      view = {
        entries = {
          name = "custom",
          selection_order = "near_cursor",
          follow_cursor = true,
        },
      },

      mapping = cmp.mapping.preset.insert({
        ["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
        ["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion
        ["<C-u>"] = cmp.mapping.scroll_docs(-4),
        ["<C-d>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
        ["<C-e>"] = cmp.mapping.abort(), -- close completion window
        ["<CR>"] = cmp.mapping.confirm({
          behavior = cmp.ConfirmBehavior.Insert,
          select = true,
        }),
        ["<Tab>"] = cmp.mapping.confirm({
          behavior = cmp.ConfirmBehavior.Insert,
          select = true,
        }),
      }),

      sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" }, -- snippets
        { name = "buffer" }, -- text within current buffer
        { name = "path" }, -- file system paths
      }),

      experimental = {
        ghost_text = true,
      },
    })
  end,
}
