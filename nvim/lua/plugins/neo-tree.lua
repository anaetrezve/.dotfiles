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

    commands = {
      -- create a new neo-tree command
      grug_far_replace = function(state)
        local node = state.tree:get_node()
        local prefills = {
          -- get the current path and get the parent directory if a file is selected
          paths = node.type == "directory" and node:get_id() or vim.fn.fnamemodify(node:get_id(), ":h"),
        }

        local grug_far = require("grug-far")
        -- instance check
        if not grug_far.has_instance("explorer") then
          grug_far.open({
            instanceName = "explorer",
            prefills = prefills,
            staticTitle = "Find and Replace from Explorer",
          })
        else
          grug_far.open_instance("explorer")
          -- updating the prefills without clearing the search and other fields
          grug_far.update_instance_prefills("explorer", prefills, false)
        end
      end,
    },

    window = {
      mappings = {
        -- map our new command to z
        z = "grug_far_replace",
      },
    },
  },
}
