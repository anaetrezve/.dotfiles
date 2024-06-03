return {
  {
  "numToStr/Comment.nvim",

  event = { "BufReadPre", "BufNewFile" },

  dependencies = {
    "JoosepAlviste/nvim-ts-context-commentstring",
  },

  config = function()
    -- import comment plugin safely
    local comment = require("Comment")

    local ts_context_commentstring = require("ts_context_commentstring.integrations.comment_nvim")

    -- enable comment
    comment.setup({
      -- for commenting tsx, jsx, svelte, html files
      pre_hook = ts_context_commentstring.create_pre_hook(),
    })
  end,
},
    {
        'folke/todo-comments.nvim',
        event = { 'BufReadPre', 'BufNewFile' },
        keys = {
            { '<leader>tq', '<cmd>TodoQuickFix<cr>', desc = 'Todo QuickFix' },
            { '<leader>tl', '<cmd>TodoLocList<cr>', desc = 'Todo LocList' },
            { '<leader>ts', '<cmd>TodoTelescope<cr>', desc = 'Todo Telescope' },
        },
        dependencies = { 'nvim-lua/plenary.nvim' },
        opts = {},
    },
}
