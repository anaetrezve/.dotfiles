return {
  {
    "nvim-treesitter/nvim-treesitter",

    dependencies = {
      {
        "nvim-treesitter/nvim-treesitter-context",
        enabled = false,
        opts = {},
      },
    },

    lazy = false, -- treesitter doesn't support lazy loading
    build = ":TSUpdate",

    config = function()
      -- Enable treesitter highlighting for all filetypes
      vim.api.nvim_create_autocmd("FileType", {
        callback = function()
          pcall(vim.treesitter.start)
        end,
      })

      -- Enable treesitter-based indentation
      vim.api.nvim_create_autocmd("FileType", {
        callback = function()
          vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
      })

      -- Enable treesitter-based folding (optional)
      vim.opt.foldmethod = "expr"
      vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
      vim.opt.foldlevel = 99 -- start with all folds open
    end,
  },

  {
    "windwp/nvim-ts-autotag",
    event = { "BufReadPre", "BufNewFile" },
    opts = {},
  },

  {
    "ckolkey/ts-node-action",
    keys = {
      { "+", "<cmd>NodeAction<cr>", desc = "Trigger Node Action" },
    },
    opts = {},
  },
}
