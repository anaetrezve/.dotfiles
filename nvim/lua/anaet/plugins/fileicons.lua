return {
    "nvim-tree/nvim-web-devicons",

  enabled = true,

  dependencies = {
    "DaikyXendo/nvim-material-icon",
  },

  config = function()
    local web_devicons = require("nvim-web-devicons")
    -- local material_icon = require("nvim-material-icon")

    web_devicons.setup({
      -- override = material_icon.get_icons(),
    })
  end,
}
