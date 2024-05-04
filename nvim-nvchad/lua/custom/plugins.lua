local cmp = require "cmp"
local actions = require("telescope.actions")

local plugins = {
  {
    "rcarriga/nvim-dap-ui",
    event = "VeryLazy",
    dependencies = "mfussenegger/nvim-dap",
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")
      require("dapui").setup()
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
    end
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    event = "VeryLazy",
    opts = function()
      return require "custom.configs.null-ls"
    end,
  },
  -- {
  --   "mhartington/formatter.nvim",
  --   event = "VeryLazy",
  --   opts = function()
  --     return require "custom.configs.formatter"
  --   end
  -- },
  -- {
  --   "mfussenegger/nvim-lint",
  --   event = "VeryLazy",
  --   config = function()
  --     require "custom.configs.lint"
  --   end
  -- },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end,
  },
  {
    "christoomey/vim-tmux-navigator",
    lazy = false,
  },
  -- {
  --   "zbirenbaum/copilot.lua",
  --   lazy = false,
  --   opts = function ()
  --     return require "custom.configs.copilot"
  --   end,
  --   config = function(_, opts)
  --     require("copilot").setup(opts)
  --   end
  -- },
  {
    "anuvyklack/pretty-fold.nvim",
    lazy = false,
    config = function()
      require("pretty-fold").setup()
    end
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "gopls",
        "cssls",
        "tailwindcss-language-server",
        "lua_ls",
        "emmet_ls",
        "eslint-lsp",
        "js-debug-adapter",
        "prettier",
        "typescript-language-server",
        "stylelint_lsp",
        "jsonls",
        "graphql",
        "stylua"

        -- "rust-analyzer",
        -- "python-lsp-server",
      },
    },
  },
  -- {
  --   "simrat39/rust-tools.nvim",
  --   ft = "rust",
  --   dependencies = "neovim/nvim-lspconfig",
  --   opts = function ()
  --     return require "custom.configs.rust-tools"
  --   end,
  --   config = function(_, opts)
  --     require('rust-tools').setup(opts)
  --   end
  -- },
  -- {
  --   "mfussenegger/nvim-dap",
  --   init = function()
  --     require("core.utils").load_mappings("dap")
  --   end
  -- },
  {
    "mfussenegger/nvim-dap",
    config = function()
      require "custom.configs.dap"
      require("core.utils").load_mappings("dap")
    end
  },
  {
    "leoluz/nvim-dap-go",
    ft = "go",
    dependencies = "mfussenegger/nvim-dap",
    config = function(_, opts)
      require("dap-go").setup(opts)
      require("core.utils").load_mappings("dap_go")
    end
  },
  {
    "olexsmir/gopher.nvim",
    ft = "go",
    config = function(_, opts)
      require("gopher").setup(opts)
    end,
    build = function()
      vim.cmd [[silent! GoInstallDeps]]
    end,
  },
  -- {
  --   'saecki/crates.nvim',
  --   ft = {"rust", "toml"},
  --   config = function(_, opts)
  --     local crates  = require('crates')
  --     crates.setup(opts)
  --     require('cmp').setup.buffer({
  --       sources = { { name = "crates" }}
  --     })
  --     crates.show()
  --     require("core.utils").load_mappings("crates")
  --   end,
  -- },
  -- {
  --   "rust-lang/rust.vim",
  --   ft = "rust",
  --   init = function ()
  --     vim.g.rustfmt_autosave = 1
  --   end
  -- },
  {
    "theHamsta/nvim-dap-virtual-text",
    lazy = false,
    config = function(_, opts)
      require("nvim-dap-virtual-text").setup()
    end
  },
  {
    "hrsh7th/nvim-cmp",
    opts = function()
      local M = require "plugins.configs.cmp"
      M.mapping["<C-k>"] = cmp.mapping.select_prev_item() -- previous suggestion
      M.mapping["<C-j>"] = cmp.mapping.select_next_item() -- next suggestion

      -- M.completion.completeopt = "menu,menuone,noselect"
      -- M.mapping["<CR>"] = cmp.mapping.confirm {
      --   behavior = cmp.ConfirmBehavior.Insert,
      --   select = false,
      -- }
      --
      -- M.mapping["<C-j>"] = cmp.mapping(function(_fallback)
      --   cmp.mapping.abort()
      --   require("copilot.suggestion").accept_line()
      -- end, {
      --     "i",
      --     "s",
      --   })
      --
      -- table.insert(M.sources, {name = "crates"})
      return M
    end,
  },
  {
    "nvim-telescope/telescope.nvim",
    opts = {
      defaults = {
      mapping = {
        n = {
          ["q"] = actions.close
        },
        i = {
           ["<Down>"] = actions.move_selection_next,
           ["<Up>"] = actions.move_selection_previous,
           ["<C-j>"] = actions.move_selection_next,
           ["<C-k>"] = actions.move_selection_previous,
          },
        },
      },
    },
  },
  {
    "nvim-tree/nvim-tree.lua",
    opts = {
  renderer = {
    icons = {
      glyphs = {
        default = "󰈚",
        symlink = "",
        folder = {
          default = "󰉋",
          empty = "",
          empty_open = "",
          open = "󰝰",
          symlink = "",
          symlink_open = "",
          arrow_open = "",
          arrow_closed = "",
        },
        git = {
          unstaged = "✗",
          staged = "✓",
          unmerged = "",
          renamed = "➜",
          untracked = "★",
          deleted = "",
          ignored = "◌",
        },
      },
    }
  }
    }
  }
}

return plugins