return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
  },
  keys = function()
    return {
      { "<leader>ff", "<cmd>Telescope find_files<cr>",                                        desc = "telescope find files" },
      { "<leader>fa", "<cmd>Telescope find_files follow=true no_ignore=true hidden=true<CR>", desc = "telescope find all files" },
      { "<leader>fw", "<cmd>Telescope live_grep<CR>",                                         desc = "telescope live grep" },
      { "<leader>fb", "<cmd>Telescope buffers<CR>",                                           desc = "telescope find buffers" },
      { "<leader>fr", "<cmd>Telescope oldfiles<CR>",                                          desc = "telescope find recently used files" },
    }
  end,

  opts = function()
    local actions = require("telescope.actions")

    return {
      defaults = {
        prompt_prefix = "   ",
        selection_caret = "  ",
        entry_prefix = "  ",
        initial_mode = "insert",
        selection_strategy = "reset",
        borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
        color_devicons = true,
        file_ignore_patterns = { "node_modules" },
        mappings = {
          n = {
            ["<ESC>"] = actions.close,
            ["<C-k>"] = actions.move_selection_previous, -- move to prev result
            ["<C-j>"] = actions.move_selection_next,     -- move to next result
          },

        },
      }
    }
  end,

  config = function(_, opts)
    local telescope = require("telescope")

    telescope.setup(opts)
  end,
}
