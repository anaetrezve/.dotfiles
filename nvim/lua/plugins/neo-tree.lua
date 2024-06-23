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
          added = "A", -- or "✚", but this is redundant info if you use git_status_colors on the name
          modified = "M", -- or "", but this is redundant info if you use git_status_colors on the name
          deleted = "D", -- this can only be used in the git_status source
          renamed = "R", -- this can only be used in the git_status source
          -- Status type
          untracked = "U",
          ignored = "",
          unstaged = "U",
          staged = "S",
          conflict = "C",
        },
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
      window = {
        mappings = {
          ["O"] = { "show_help", nowait = false, config = { title = "Order by", prefix_key = "o" } },
        },
      },
    },
  },
}
