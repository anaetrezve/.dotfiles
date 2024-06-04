return {
  "nvim-neo-tree/neo-tree.nvim",
  enabled = true,
  branch = "v3.x",
  cmd = "Neotree",
  keys = {
    {
      "<Leader>e",
      function()
        require("neo-tree.command").execute({
          toggle = true,
          source = "filesystem",
          position = "left",
        })
      end,
      desc = "Neotree Filesystem",
    },
    {
      "<Leader>fe",
      function()
        require("neo-tree.command").execute({
          toggle = true,
          source = "filesystem",
          position = "float",
        })
      end,
      desc = "Neotree Float Filesystem",
    },
    {
      "<Leader>b",
      function()
        require("neo-tree.command").execute({
          toggle = true,
          source = "buffers",
          position = "left",
        })
      end,
      desc = "Neotree Float Buffers",
    },
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  opts = {
    popup_border_style = "single",
    sources = { "filesystem", "buffers", "git_status", "document_symbols" },
    open_files_do_not_replace_types = { "terminal", "Trouble", "trouble", "qf", "Outline" },
    source_selector = {
      winbar = true,
      statusline = false,
    },
    default_component_configs = {
      indent = {
        with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
        -- expander_collapsed = "",
        -- expander_expanded = "",
        expander_highlight = "NeoTreeExpander",
      },

      icon = {
        folder_closed = "",
        folder_open = "",
        folder_empty = "",
      },
      git_status = {
        symbols = {
          -- Status type
          unstaged = "",
        },
      },
      diagnostics = {
        symbols = {
          hint = "󰌶",
          info = "",
          warn = "",
          error = "",
        },
      },
    },
    -- commands = {
    --   image_wezterm = function(state)
    --     local node = state.tree:get_node()
    --     if node.type == "file" then
    --       require("image_preview").PreviewImage(node.path)
    --     end
    --   end,
    -- },
  },
}
