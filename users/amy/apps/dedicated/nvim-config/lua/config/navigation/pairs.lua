---@type ConfigModule
local module = {
  pkgs = {
    {
      'echasnovski/mini.pairs',
      config = function()
        require('mini.pairs').setup {}
      end,
    },
  },
}

return module
