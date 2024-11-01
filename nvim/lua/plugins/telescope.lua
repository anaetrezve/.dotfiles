return {
  "nvim-telescope/telescope.nvim",

  dependencies = {
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-telescope/telescope-live-grep-args.nvim",
    "nvim-telescope/telescope-ui-select.nvim",
  },

  keys = {
    {
      "<leader>ff",
      "<cmd>Telescope find_files hidden=true<cr>",
      desc = "telescope find files",
    },
    {
      "<leader>fa",
      "<cmd>Telescope find_files follow=true no_ignore=true hidden=true<CR>",
      desc = "telescope find all files",
    },
    {
      "<leader>fw",
      ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>",
      desc = "telescope live grep",
    },
    {
      "<leader>fb",
      "<cmd>Telescope buffers<CR>",
      desc = "telescope find buffers",
    },
    {
      "<leader>fr",
      "<cmd>Telescope oldfiles hiddne=true<CR>",
      desc = "telescope find recently used files",
    },
    {
      "<leader>ft",
      "<cmd>TodoTelescope<cr>",
      desc = "Find todos",
    },
  },

  opts = function()
    local actions = require("telescope.actions")
    local trouble = require("trouble")
    local trouble_telescope = require("trouble.sources.telescope")
    local transform_mod = require("telescope.actions.mt").transform_mod

    -- or create your custom action
    local custom_actions = transform_mod({
      open_trouble_qflist = function()
        trouble.toggle("quickfix")
      end,
    })

    return {
      defaults = {
        path_display = {
          filename_first = {
            reverse_directories = true,
          },
        },
        results_title = false,
        -- dynamic_preview_title = true,
        prompt_prefix = "   ",
        selection_caret = "  ",
        entry_prefix = "  ",
        initial_mode = "insert",
        selection_strategy = "reset",
        borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
        color_devicons = true,
        file_ignore_patterns = { "node_modules", ".git" },
        layout_strategy = "horizontal",
        sorting_strategy = "ascending",
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
        mappings = {
          -- Scroll preview up - <C-u>
          -- Scroll preview down - <C-d>
          -- Scroll preview left - <C-l>
          -- Scroll preview right - <C-h>
          i = {
            ["<ESC>"] = actions.close,
            ["<C-k>"] = actions.move_selection_previous, -- move to prev result
            ["<C-j>"] = actions.move_selection_next, -- move to next result
            ["<C-q>"] = actions.send_selected_to_qflist + custom_actions.open_trouble_qflist,
            ["<C-t>"] = trouble_telescope.open,
            ["<C-h>"] = actions.preview_scrolling_right,
            ["<C-l>"] = actions.preview_scrolling_left,
          },
          n = {
            ["<C-h>"] = actions.preview_scrolling_right,
            ["<C-l>"] = actions.preview_scrolling_left,
          },
        },
        extensions = {
          fzf = {
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
          },
          ["ui-select"] = {
            require("telescope.themes").get_dropdown(),
          },
        },
      },
    }
  end,

  config = function(_, opts)
    local telescope = require("telescope")

    telescope.setup(opts)

    telescope.load_extension("fzf")
    telescope.load_extension("live_grep_args")
    telescope.load_extension("ui-select")
  end,
}
