return {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.6",

  dependencies = { "nvim-lua/plenary.nvim", "nvim-treesitter/nvim-treesitter" },

  keys = function()
    return {
      { mode = { "n" }, "<leader>fw", "<cmd>Telescope live_grep<CR>", desc = "telescope live grep" },
      { mode = { "n" }, "<leader>fb", "<cmd>Telescope buffers<CR>", desc = "telescope find buffers" },
      { mode = { "n" }, "<leader>fh", "<cmd>Telescope help_tags<CR>", desc = "telescope help page" },
      { mode = { "n" }, "<leader>ma", "<cmd>Telescope marks<CR>", desc = "telescope find marks" },
      { mode = { "n" }, "<leader>fo", "<cmd>Telescope oldfiles<CR>", desc = "telescope find oldfiles" },
      {
        mode = { "n" },
        "<leader>fz",
        "<cmd>Telescope current_buffer_fuzzy_find<CR>",
        desc = "telescope find in current buffer",
      },
      { mode = { "n" }, "<leader>cm", "<cmd>Telescope git_commits<CR>", desc = "telescope git commits" },
      { mode = { "n" }, "<leader>gt", "<cmd>Telescope git_status<CR>", desc = "telescope git status" },
      { mode = { "n" }, "<leader>pt", "<cmd>Telescope terms<CR>", desc = "telescope pick hidden term" },
      { mode = { "n" }, "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "telescope find files" },
      {
        mode = { "n" },
        "<leader>fa",
        "<cmd>Telescope find_files follow=true no_ignore=true hidden=true<CR>",
        desc = "telescope find all files",
      },
    }
  end,

  opts = function()
    local actions = require("telescope.actions")

    return {
      defaults = {
        vimgrep_arguments = {
          "rg",
          "-L",
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case",
        },
        prompt_prefix = "   ",
        selection_caret = "  ",
        entry_prefix = "  ",
        initial_mode = "insert",
        selection_strategy = "reset",
        sorting_strategy = "ascending",
        layout_strategy = "horizontal",
        layout_config = {
          horizontal = {
            prompt_position = "top",
            preview_width = 0.55,
            results_width = 0.8,
          },
          vertical = {
            mirror = false,
          },
          width = 0.87,
          height = 0.80,
          preview_cutoff = 120,
        },
        file_ignore_patterns = { "node_modules" },
        path_display = { "smart" },
        winblend = 0,
        border = {},
        borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
        color_devicons = true,
        set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
        -- Developer configurations: Not meant for general override
        mappings = {
          n = { ["q"] = actions.close },
          i = {
            ["<C-k>"] = actions.move_selection_previous, -- move to prev result
            ["<C-j>"] = actions.move_selection_next, -- move to next result
            -- ["<C-q>"] = actions.send_selected_to_qflist + custom_actions.open_trouble_qflist,
            -- ["<C-t>"] = trouble_telescope.smart_open_with_trouble,
          },
        },
      },
    }
  end,

  config = function(_, opts)
    local telescope = require("telescope")
    telescope.setup(opts)
  end,
}
