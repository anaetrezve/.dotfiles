return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    "hrsh7th/cmp-buffer", -- source for text in buffer
    "hrsh7th/cmp-path", -- source for file system paths
    {
      "L3MON4D3/LuaSnip",
      -- follow latest release.
      version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
      -- install jsregexp (optional!).
      build = "make install_jsregexp",
    },
    "saadparwaiz1/cmp_luasnip", -- for autocompletion
    "rafamadriz/friendly-snippets", -- useful snippets
    "onsails/lspkind.nvim", -- vs-code like pictograms
  },
  config = function()
    local cmp = require("cmp")

    local luasnip = require("luasnip")

    local lspkind = require("lspkind")

    -- loads vscode style snippets from installed plugins (e.g. friendly-snippets)
    require("luasnip.loaders.from_vscode").lazy_load()
    local kind_icons = {
      Class = " ",
      Color = " ",
      Comment = "//",
      Constant = " ",
      Constructor = " ",
      Enum = " ",
      EnumMember = " ",
      Event = "",
      Field = "󰄶 ",
      File = " ",
      Folder = " ",
      Function = "ƒ ",
      Interface = " ",
      Keyword = "󰌆 ",
      Method = " ",
      Module = "󰏗 ",
      Operator = "󰆕 ",
      Property = " ",
      Reference = " ",
      Snippet = " ",
      String = "󱌯 ",
      Struct = " ",
      Text = " ",
      TypeParameter = "󰅲 ",
      Unit = " ",
      Value = "󰎠 ",
      Variable = "󰀫",
    }

    cmp.setup({
      completion = {
        completeopt = "menu,menuone,preview,noselect",
      },
      snippet = { -- configure how nvim-cmp interacts with snippet engine
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      window = {
        completion = {
          border = { "┌", "─", "┐", "│", "┘", "─", "└", "│" },
          winhighlight = "Normal:CmpPmenu,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
        },
        documentation = {
          border = { "┌", "─", "┐", "│", "┘", "─", "└", "│" },
          winhighlight = "Normal:CmpPmenu,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
        },
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
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
        ["<C-e>"] = cmp.mapping.abort(), -- close completion window
        ["<CR>"] = cmp.mapping.confirm({ select = false }),
      }),
      -- sources for autocompletion
      sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" }, -- snippets
        { name = "buffer" }, -- text within current buffer
        { name = "path" }, -- file system paths
      }),

      -- configure lspkind for vs-code like pictograms in completion menu
      formatting = {
        fields = { "abbr", "kind", "menu" },
        format = function(entry, vim_item)
          -- Kind icons
          -- This concatonates the icons with the name of the item kind
          vim_item.kind = string.format("%s %s", kind_icons[vim_item.kind], vim_item.kind)
          -- Trim text function
          function trim(text)
            local max = 40
            if text and text:len(1, max) > max then
              text = text:sub(1, max) .. "..."
            end
            return text
          end
          vim_item.abbr = trim(vim_item.abbr)
          -- Source
          vim_item.menu = ({
            nvim_lsp = "( LSP )",
            nvim_lsp_signature_help = "( Signature )",
            luasnip = "( LuaSnip )",
            buffer = "( Buffer )",
            cmp_yanky = "( Yanky )",
            path = "( Path )",
            nvim_lua = "( Lua )",
            treesitter = "( Treesitter )",
            look = "( Look )",
            cmdline = "(CMDLine)",
            cmdline_history = "(CMDLine History)",
          })[entry.source.name]
          return vim_item
        end,
      },
      experimental = {
        ghost_text = true,
      },
    })
  end,
}
