---@type ConfigModule
local module = {
  pkgs = {
    {
      'kylechui/nvim-surround',
      config = function()
        require('nvim-surround').setup {}
      end,
    },
  },
}

return module
