return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
    -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
  },

  keys = {
    {
      "<leader>e",
      function()
        require("neo-tree.command").execute({ toggle = true, position = "left", dir = vim.uv.cwd() })
      end,
      desc = "Explorer NeoTree Filesystem (cwd)",
    },
    {
      "<leader>fe",
      function()
        require("neo-tree.command").execute({ toggle = true, position = "float", dir = vim.uv.cwd() })
      end,
      desc = "Explorer NeoTree Filesystem (cwd)",
    },
    {
      "<leader>fE",
      function()
        require("neo-tree.command").execute({ toggle = true, position = "float" })
      end,
      desc = "Explorer NeoTree Filesystem (Root Dir)",
    },
    {
      "<leader>E",
      function()
        require("neo-tree.command").execute({ toggle = true, position = "left" })
      end,
      desc = "Explorer NeoTree Filesystem (Root Dir)",
    },
    {
      "<leader>ge",
      function()
        require("neo-tree.command").execute({ source = "git_status", toggle = true, position = "float" })
      end,
      desc = "Git Explorer NeoTree",
    },
    {
      "<leader>be",
      function()
        require("neo-tree.command").execute({ source = "buffers", toggle = true, position = "float" })
      end,
      desc = "Buffer Explorer NeoTree",
    },
  },

  opts = {
    popup_border_style = "single",
    enable_diagnostics = false,
    sources = { "filesystem", "buffers", "git_status" },
    open_files_do_not_replace_types = { "terminal", "Trouble", "trouble", "qf", "Outline" },
    default_component_configs = {
      modified = {
        symbol = "",
        highlight = "NeoTreeModified",
      },
      name = {
        trailing_slash = false,
        use_git_status_colors = true,
        highlight = "NeoTreeFileName",
      },
      git_status = {
        symbols = {
          added = " ", -- or "✚", but this is redundant info if you use git_status_colors on the name
          modified = " ", -- or "", but this is redundant info if you use git_status_colors on the name
          deleted = " ", -- this can only be used in the git_status source
          renamed = " ", -- this can only be used in the git_status source
          -- Status type
          untracked = " ",
          ignored = " ",
          unstaged = " ",
          staged = " ",
          conflict = "C",
        },
      },

      icon = {
        folder_closed = "",
        folder_open = "",
        folder_empty = "󰜌",
      },
    },

    filesystem = {
      filtered_items = {
        hide_dotfiles = false,
        hide_gitignored = false,
      },
      follow_current_file = {
        enabled = true,
      },
      bind_to_cwd = false,
      use_libuv_file_watcher = true,

      window = {
        mappings = {
          ["O"] = { "show_help", nowait = false, config = { title = "Order by", prefix_key = "o" } },
        },
      },
    },
  },

  config = function(_, opts)
    require("neo-tree").setup(opts)
  end,
}
