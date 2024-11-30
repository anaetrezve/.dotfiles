local vim_mode = require("plugins.heirline.mode")

return {
  "rebelot/heirline.nvim",

  enabled = false,

  config = function()
    local colors = require("catppuccin.palettes").get_palette("mocha")
    local conditions = require("heirline.conditions")

    local disabled_buffers = {
      condition = function()
        return conditions.buffer_matches({
          filetype = { "dashboard", "neo-tree", "NvimTree", "dbui", "packer", "startify", "fugitive", "fugitiveblame" },
          buftype = { "nofile", "help", "quickfix", "terminal" },
        })
      end,
      provider = " ",
    }

    local help_file_name = {
      condition = function()
        return vim.bo.filetype == "help"
      end,
      provider = function()
        local filename = vim.api.nvim_buf_get_name(0)
        return vim.fn.fnamemodify(filename, ":t")
      end,
      hl = { fg = colors.blue },
    }

    local config = {
      statusline = {
        -- init = function(self)
        --   self.filename = vim.api.nvim_buf_get_name(0)
        --   self.short_filename = vim.fn.fnamemodify(self.filename, ":.")
        --   if self.short_filename == "" then
        --     self.short_filename = "[No Name]"
        --   end
        --
        --   local extension = vim.fn.fnamemodify(self.filename, ":e")
        --   self.icon, self.icon_color =
        --     require("nvim-web-devicons").get_icon_color(self.filename, extension, { default = true })
        --   self.mode = vim.fn.mode(1)
        -- end,
        --
        -- stop_when = function(_, out)
        --   return out ~= ""
        -- end,
        vim_mode,
        help_file_name,
        disabled_buffers,
      },

      -- winbar = {},
      -- tabline = {},
      -- statuscolumn = {},
    }

    require("heirline").setup(config)
  end,
}
