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

    vim.api.nvim_create_autocmd("FileType", {
      pattern = "TelescopeResults",
      callback = function(ctx)
        vim.api.nvim_buf_call(ctx.buf, function()
          vim.fn.matchadd("TelescopeParent", "- .*$")
          vim.api.nvim_set_hl(0, "TelescopeParent", { link = "Comment" })
        end)
      end,
    })

    local function filenameFirst(_, path)
      local tail = vim.fs.basename(path)
      local parent = vim.fs.dirname(path)
      if parent == "." then
        return tail
      end
      return string.format("%s - %s", tail, parent)
    end

    return {
      pickers = {
        find_files = {
          path_display = filenameFirst,
        },
      },

      defaults = {
        prompt_prefix = "   ",
        selection_caret = "  ",
        entry_prefix = "  ",
        initial_mode = "insert",
        selection_strategy = "reset",
        borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
        color_devicons = true,
        file_ignore_patterns = { "node_modules" },
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
          i = {
            ["<ESC>"] = actions.close,
            ["<C-k>"] = actions.move_selection_previous, -- move to prev result
            ["<C-j>"] = actions.move_selection_next,     -- move to next result
          }
        },
      }
    }
  end,

  config = function(_, opts)
    local telescope = require("telescope")

    telescope.setup(opts)
  end,
}
