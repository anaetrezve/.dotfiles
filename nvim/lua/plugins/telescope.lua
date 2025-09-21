return {
  "nvim-telescope/telescope.nvim",
  enabled = false,
  dependencies = {
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-telescope/telescope-live-grep-args.nvim",
    "nvim-telescope/telescope-ui-select.nvim",
    "debugloop/telescope-undo.nvim",
    -- "piersolenski/telescope-import.nvim",
  },

  keys = {
    {
      "<leader>fa",
      "<cmd>Telescope find_files follow=true no_ignore=true hidden=true<CR>",
      desc = "Find all files",
    },
    { "<leader>fb", "<cmd>Telescope buffers<cr>",                     desc = "Find Buffers" },
    { "<leader>fc", ":lua require'telescope.builtin'.commands{}<cr>", desc = "List Commands" },
    { "<leader>fd", "<cmd>Telescope diagnostics<cr>",                 desc = "Find Diagnostics" },
    -- { "<leader>fe", "<cmd>Telescope file_browser<cr>", desc = "File Browser" },
    { "<leader>ff", "<cmd>Telescope find_files hidden=true<cr>",      desc = "Find Files" },
    -- { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Find Word" },
    {
      "<leader>fg",
      ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>",
      desc = "Live grep",
    },
    { "<leader>fh", "<cmd>Telescope help_tags<cr>",            desc = "Find Help" },
    -- { "<leader>fi", "<cmd>Telescope import<cr>", desc = "Find Imports" },
    -- { "<leader>fj", "<cmd>Telescope emoji<cr>", desc = "Find emoji" },
    { "<leader>fk", "<cmd>Telescope keymaps<cr>",              desc = "Find Keymaps" },
    { "<leader>fl", "<cmd>Telescope highlights<cr>",           desc = "Find Highlights" },
    -- { "<leader>fm", "<cmd>Telescope heading<cr>", desc = "Find Heading" },
    { "<leader>fo", "<cmd>Telescope oldfiles hidden=true<cr>", desc = "Recently opened files" },
    -- { "<leader>fp", "<cmd>Telescope spell_suggest<cr>", desc = "Find Spell Suggest" },
    { "<leader>fq", "<cmd>Telescope quickfix<cr>",             desc = "Find Quickix" },
    {
      "<leader>fw",
      function()
        require("telescope-live-grep-args.shortcuts").grep_word_under_cursor()
      end,
      mode = { "n", "v" },
      desc = "Word Under Cursor",
    },
    {
      "<leader>fs",
      function()
        require("telescope-live-grep-args.shortcuts").grep_visual_selection()
      end,
      mode = { "n", "v" },
      desc = "Find Selected Text",
    },
    -- { "<leader>fs", "<cmd>Telescope symbols<cr>", desc = "Find Symbols" },
    -- { "<leader>ft", "<cmd>Telescope git_files<cr>", desc = "Find Git Files" },
    { "<leader>fu", "<cmd>Telescope undo<cr>", desc = "Find Undo" },
    -- { "<leader>fy", "<cmd>Telescope yank_history<cr>", mode = { "n", "x" }, desc = "Find yanks" },
    -- { "<leader>fz", "<cmd>Telescope zoxide list<cr>", desc = "Find Directory" },
  },

  opts = function()
    local actions = require("telescope.actions")
    local action_state = require("telescope.actions.state")
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
        -- path_display = {
        --   filename_first = {
        --     reverse_directories = false,
        --   },
        -- },
        results_title = false,
        -- dynamic_preview_title = true,
        prompt_prefix = "   ",
        selection_caret = "  ",
        entry_prefix = "  ",
        initial_mode = "insert",
        selection_strategy = "reset",
        borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
        color_devicons = true,
        file_ignore_patterns = {
          "node_modules",
          ".git/",
          ".cache",
          "%.o",
          "%.a",
          "%.out",
          "%.class",
          "%.pdf",
          "%.mkv",
          "%.mp4",
          "%.zip",
        },
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
            -- ["<ESC>"] = actions.close,
            ["<Esc>"] = function(prompt_bufnr)
              local prompt = action_state.get_current_line()
              if prompt == "" then
                actions.close(prompt_bufnr)
              else
                -- If there is value then change to normal mode in the input
                vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", true)
              end
            end,
            ["<C-k>"] = actions.move_selection_previous, -- move to prev result
            ["<C-j>"] = actions.move_selection_next,     -- move to next result
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
            fuzzy = false,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
          },
          ["ui-select"] = {
            require("telescope.themes").get_dropdown(),
          },
          undo = {
            initial_mode = "normal",
            use_delta = true,
            side_by_side = true,
            layout_strategy = "vertical",
            layout_config = {
              preview_height = 0.8,
            },
          },
        },
      },
      -- pickers = {
      --   grep_string = {
      --     initial_mode = "normal",
      --     theme = "ivy",
      --   },
      --   live_grep = {
      --     theme = "ivy",
      --   },
      -- },
    }
  end,

  config = function(_, opts)
    local telescope = require("telescope")

    telescope.setup(opts)

    telescope.load_extension("fzf")
    telescope.load_extension("live_grep_args")
    telescope.load_extension("ui-select")
    telescope.load_extension("undo")
  end,
}
