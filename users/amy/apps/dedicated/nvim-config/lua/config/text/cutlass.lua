---@type ConfigModule
local module = {
  pkgs = {
    {
      'gbprod/cutlass.nvim',
      config = function()
        require('cutlass').setup {
          cut_key = 'x',
        }
      end,
    },
  },
}

return module
