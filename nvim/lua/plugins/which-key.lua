return {
  "folke/which-key.nvim",

  event = "VeryLazy",

  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Buffer Local Keymaps (which-key)",
    },
  },
  opts = {
    preset = "helix", -- false | "classic" | "modern" | "helix"
    expand = 0,
    spec = {
      {
        mode = { "n", "v" },
        { "g", group = "+LSP Functions" },
        -- { "grw", group = "+LSP Workspace Folders" },
        { "<leader>cc", group = "+Copilot" },
        { "<leader>f", group = "+File" }, -- Telescope
        { "<leader>h", group = "+Git & Harpoon" }, -- Gitsigns & Harpoon
        -- { "<leader>l", group = "+Lazy", icon = "💤" }, -- Lazy & LTeX
        -- { "<leader>m", group = "+Show Messages" }, -- Messages
        -- { "<leader>t", group = "+ToggleTerm / Todo Comments" }, -- ToggleTerm & Todo Comments
        -- { "<leader>b", group = "+Buffer" }, -- Bufferline.nvim
        -- { "<leader>g", group = "+Glance LSP" }, -- Glance LSP locations
        -- { "<leader>i", group = "+IncRename / Inlay Hints" }, -- IncRename
        -- { "<leader>n", group = "+Noice" }, -- Noice.nvim
        { "<leader>x", group = "+Trouble" }, -- Trouble.nvim
      },
    },
    win = {
      border = "single",
      no_overlap = false,
      title_pos = "center",
      -- height = { min = 4, max = 15 },
      -- col = 3,
    },
    -- sort = { "manual", "group", "lower" },
  },
}
