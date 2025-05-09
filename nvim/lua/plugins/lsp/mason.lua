return { 
  {
    'mason-org/mason.nvim',
    build = ':MasonUpdate',
    lazy = true,
    opts = {
      ui = {
        icons = {
          package_installed = ' ',
          package_pending = ' ',
          package_uninstalled = ' ',
        },
        border = 'single',
        height = 0.8,
      },
    },
  },
  {
    'mason-org/mason-lspconfig.nvim',
    enabled = true,
    lazy = true,
    opts = {
      automatic_enable = false,
    },
  }
}

