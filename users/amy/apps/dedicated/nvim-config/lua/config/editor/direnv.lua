---@type ConfigModule
local module = {
  pkgs = {
    {
      'actionshrimp/direnv.nvim',
      config = function()
        require('direnv-nvim').setup {
          type = 'dir',
        }
      end,
    },
  },
}

return module
