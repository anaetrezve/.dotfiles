local conditions = {
  buffer_not_empty = function()
    return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
  end,
  buffer_empty = function()
    return vim.fn.empty(vim.fn.expand("%:t")) == 1
  end,
  screen_width = function(min_w)
    return function()
      return vim.o.columns > min_w
    end
  end,
  check_git_workspace = function()
    local filepath = vim.fn.expand("%:p:h")
    local gitdir = vim.fn.finddir(".git", filepath .. ";")
    return gitdir and #gitdir > 0 and #gitdir < #filepath
  end,
  diff_mode = function()
    return vim.o.diff == true
  end,
  hide_in_width = function()
    return vim.fn.winwidth(0) > 80
  end,
}

return {
  "nvim-lualine/lualine.nvim",

  enabled = false,

  dependencies = { "nvim-tree/nvim-web-devicons" },

  opts = function()
    local colors = require("catppuccin.palettes").get_palette("mocha")
    local config = {
      options = {
        icons_enabled = true,
        theme = "catppuccin",
        -- component_separators = { left = "|", right = "|" },
        -- section_separators = { left = "", right = "" },

        component_separators = "",
        section_separators = "",
        disabled_filetypes = {

          statusline = { "neo-tree", "git", "fugitive", "toggleterm", "trouble" },
          winbar = { "neo-tree", "DiffviewFiles", "git" },
        },

        ignore_focus = {},
        always_divide_middle = false,
        globalstatus = true,

        refresh = {
          statusline = 1000,
          tabline = 1000,
          winbar = 1000,
        },
      },

      sections = {
        lualine_a = { "mode" },
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
      },

      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
      },

      tabline = {},
      winbar = {},
      inactive_winbar = {},
      extensions = {},
    }

    local function insert_left(component)
      table.insert(config.sections.lualine_c, component)
    end

    local function insert_right(component)
      table.insert(config.sections.lualine_x, component)
    end

    insert_left({
      "branch",
      icon = "",
      color = { fg = colors.fg, bg = colors.bg, gui = "bold" },
    })

    insert_left({
      "diff",
      symbols = { added = " ", modified = " ", removed = " " },
      diff_color = {
        added = { fg = colors.green },
        modified = { fg = colors.orange },
        removed = { fg = colors.red },
      },
      cond = conditions.hide_in_width,
    })

    insert_left({
      "diagnostics",
      sources = { "nvim_diagnostic" },
      symbols = { error = " ", warn = " ", info = " " },
      diagnostics_color = {
        color_error = { fg = colors.red },
        color_warn = { fg = colors.yellow },
        color_info = { fg = colors.cyan },
      },
    })

    insert_left({
      function()
        return "%="
      end,
    })

    insert_right({
      "location",
      color = { fg = colors.fg_dark },
      cond = conditions.buffer_not_empty,
    })

    insert_right({
      "encoding",
    })

    insert_right({
      "filetype",
    })

    return config
  end,
}
