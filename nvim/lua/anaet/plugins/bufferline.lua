return {
  "akinsho/bufferline.nvim",
  event = "VeryLazy",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  keys = {
    -- { "<leader>bpn", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle Pin" },
    -- { "<leader>bPn", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete Non-Pinned Buffers" },
    -- { "<leader>bco", "<Cmd>BufferLineCloseOthers<CR>", desc = "Delete Other Buffers" },
    -- { "<leader>bdr", "<Cmd>BufferLineCloseRight<CR>", desc = "Delete Buffers to the Right" },
    -- { "<leader>bdl", "<Cmd>BufferLineCloseLeft<CR>", desc = "Delete Buffers to the Left" },
    { "<S-Tab>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
    { "<Tab>", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
  },
  opts = function()
    -- options = {
    --   -- stylua: ignore
    --   close_command = function(n) require("mini.bufremove").delete(n, false) end,
    --   -- stylua: ignore
    --   right_mouse_command = function(n) require("mini.bufremove").delete(n, false) end,
    --   diagnostics = "nvim_lsp",
    --   always_show_bufferline = true,
    --   offsets = {
    --     {
    --       filetype = "neo-tree",
    --       text = "File Explorer",
    --       highlight = "Directory",
    --       text_align = "left",
    --     },
    --   },
    -- },

    local mocha = require("catppuccin.palettes").get_palette("mocha")

    return {
      options = {
        close_command = function(n)
          require("mini.bufremove").delete(n, false)
        end,

        offsets = {
          {
            filetype = "neo-tree",
            text = "File Explorer",
            highlight = "Directory",
            text_align = "left",
          },
        },
        -- indicator = {
        --   -- icon = '▎',
        --   style = "underline", -- 'icon' | 'underline' | 'none'
        -- },
        -- -- name_formatter = function(buf) -- buf contains a "name", "path" and "bufnr"
        -- --     -- remove extension from markdown files for example
        -- --     if buf.name:match('%.md') then
        -- --         return vim.fn.fnamemodify(buf.name, ':t:r')
        -- --     end
        -- -- end,
        tab_size = 20,
        diagnostics = "nvim_lsp",
        diagnostics_indicator = function(count, level, diagnostics_dict, context)
          local ret = (diagnostics_dict.error and " " .. diagnostics_dict.error .. " " or "")
            .. (diagnostics_dict.warning and " " .. diagnostics_dict.warning or "")
            .. (diagnostics_dict.hint and " " .. diagnostics_dict.hint .. " " or "")
          return vim.trim(ret)
        end,
        ---@type 'thin' | 'thick' | 'slant' | 'padded_slant' | 'slope' | 'padded_slope'
        separator_style = "thin",
        groups = {
          options = {
            toggle_hidden_on_enter = true,
          },
          items = {
            require("bufferline.groups").builtin.pinned:with({ icon = "" }),
          },
        },
      },
      highlights = require("catppuccin.groups.integrations.bufferline").get({
        custom = {
          all = {
            ---@diagnostic disable: need-check-nil
            info = { fg = mocha.surface2 },
            info_diagnostic = { fg = mocha.surface2 },
            hint = { fg = mocha.surface2 },
            hint_diagnostic = { fg = mocha.surface2 },
            warning = { fg = mocha.surface2 },
            warning_diagnostic = { fg = mocha.surface2 },
            error = { fg = mocha.surface2 },
            error_diagnostic = { fg = mocha.surface2 },
            separator = { fg = mocha.base, bg = mocha.base },
            separator_visible = { fg = mocha.base, bg = mocha.base },
            separator_selected = { fg = mocha.base, bg = mocha.base },
          },
        },
      }),
      -- highlights = require('rose-pine.plugins.bufferline'),
    }
  end,
  config = function(_, opts)
    require("bufferline").setup(opts)
  end,
}
