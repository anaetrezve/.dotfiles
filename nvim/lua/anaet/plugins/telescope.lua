return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  lazy = false,
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-tree/nvim-web-devicons",
    "folke/todo-comments.nvim",
  },
  keys = {
    { mode = { "n" }, "<leader>fw", "<cmd>Telescope live_grep<CR>", desc = "telescope live grep" },
    { mode = { "n" }, "<leader>fb", "<cmd>Telescope buffers<CR>", desc = "telescope find buffers" },
    { mode = { "n" }, "<leader>fh", "<cmd>Telescope help_tags<CR>", desc = "telescope help page" },
    { mode = { "n" }, "<leader>ma", "<cmd>Telescope marks<CR>", desc = "telescope find marks" },
    {
      mode = { "n" },
      "<leader>fz",
      "<cmd>Telescope current_buffer_fuzzy_find<CR>",
      desc = "telescope find in current buffer",
    },
    { mode = { "n" }, "<leader>cm", "<cmd>Telescope git_commits<CR>", desc = "telescope git commits" },
    { mode = { "n" }, "<leader>gt", "<cmd>Telescope git_status<CR>", desc = "telescope git status" },
    { mode = { "n" }, "<leader>pt", "<cmd>Telescope terms<CR>", desc = "telescope pick hidden term" },
    { mode = { "n" }, "<leader>fr", "<cmd>Telescope oldfiles<CR>", desc = "telescope find oldfiles" },
    { mode = { "n" }, "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "telescope find files" },
    {
      mode = { "n" },
      "<leader>fa",
      "<cmd>Telescope find_files follow=true no_ignore=true hidden=true<CR>",
      desc = "telescope find all files",
    },
  },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")
    local transform_mod = require("telescope.actions.mt").transform_mod

    local trouble = require("trouble")
    local trouble_telescope = require("trouble.sources.telescope")

    -- or create your custom action
    local custom_actions = transform_mod({
      open_trouble_qflist = function(prompt_bufnr)
        trouble.toggle("quickfix")
      end,
    })

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

    telescope.setup({
      pickers = {
        find_files = {
          path_display = filenameFirst,
        },
      },
      defaults = {
        prompt_prefix = "   ",
        -- selection_caret = "   ",
        selection_caret = "  ",
        entry_prefix = "  ",
        initial_mode = "insert",
        selection_strategy = "reset",
        winblend = 0,
        borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
        layout_strategy = "horizontal",
        layout_config = {
          horizontal = {
            prompt_position = "bottom",
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
        file_ignore_patterns = {
          "node_modules",
        },
        mappings = {
          i = {
            ["<C-k>"] = actions.move_selection_previous, -- move to prev result
            ["<C-j>"] = actions.move_selection_next, -- move to next result
            ["<C-q>"] = actions.send_selected_to_qflist + custom_actions.open_trouble_qflist,
            ["<C-t>"] = trouble_telescope.open,
          },
        },
      },
    })

    telescope.load_extension("fzf")
  end,
}
