return {
  "williamboman/mason.nvim",

  opts = {
    ui = {
      icons = {
        package_pending = " ",
        package_installed = "󰄳 ",
        package_uninstalled = " 󰚌",
      },
    },
  },

  config = function(_, opts)
    local mason = require("mason")

    mason.setup(opts)
  end,
}
