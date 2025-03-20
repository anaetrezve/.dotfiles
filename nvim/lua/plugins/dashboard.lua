return {
  "nvimdev/dashboard-nvim",

  event = "VimEnter",

  dependencies = { { "nvim-tree/nvim-web-devicons" } },

  opts = function()
    local logo = [[
███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
      ]]

    logo = string.rep("\n", 2) .. logo .. "\n"

    local options = {
      theme = "doom",
      hide = {
        statusline = true,
      },
      config = {
        header = vim.split(logo, "\n"),
        -- header = {},
        center = {
          {
            action = "lua require('telescope.builtin').find_files()",
            -- action = "lua Telescope find_files hidden=true",
            desc = " Find File",
            icon = " ",
            key = "f",
          },
          {
            action = "ene | startinsert",
            desc = " New File",
            icon = " ",
            key = "n",
          },
          {
            action = "lua require('telescope.builtin').oldfiles()",
            desc = " Recent Files",
            icon = " ",
            key = "o",
          },
          {
            action = "lua require('telescope.builtin').live_grep()",
            desc = " Find Text",
            icon = " ",
            key = "g",
          },
          {
            action = function()
              vim.cmd("cd ~/.dotfiles/nvim/")
              require("telescope.builtin").find_files()
            end,
            desc = " Neovim Config",
            icon = " ",
            key = "c",
          },
          {
            action = function()
              vim.cmd("bd")
              require("neo-tree.command").execute({ toggle = true })
            end,
            desc = " Open Sidebar",
            icon = " ",
            key = "s",
          },
          -- {
          --   action = "lua ",
          --   desc = " Config",
          --   icon = " ",
          --   key = "c",
          -- },
          -- {
          --   action = 'lua require("persistence").load()',
          --   desc = " Restore Session",
          --   icon = " ",
          --   key = "s",
          -- },
          {
            action = function()
              vim.api.nvim_input("<cmd>qa<cr>")
            end,
            desc = " Quit",
            icon = " ",
            key = "q",
          },
        },
        footer = function()
          local stats = require("lazy").stats()
          local ms = math.floor(stats.startuptime) .. " ms"
          local text = "  Loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms
          local line = string.rep("─", #text)
          return {
            line,
            text,
            line,
          }
        end,
      },
    }

    for _, button in ipairs(options.config.center) do
      button.desc = button.desc .. string.rep(" ", 27 - #button.desc)
      button.key_format = "  %s"
    end

    return options
  end,
}
