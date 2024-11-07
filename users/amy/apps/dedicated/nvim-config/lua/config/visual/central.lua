---@type ConfigModule
local module = {
  pkgs = {
    {
      'MagnetizedFreckles/centerscroll.nvim',
      config = function()
        require('centerscroll').setup {}
      end,
    },
  },
}

return module
