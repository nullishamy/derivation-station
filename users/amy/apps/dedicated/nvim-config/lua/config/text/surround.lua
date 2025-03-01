---@type ConfigModule
local module = {
  pkgs = {
    {
      'echasnovski/mini.nvim',
      config = function()
        require('mini.surround').setup {}
      end,
    },
  },
}

return module
