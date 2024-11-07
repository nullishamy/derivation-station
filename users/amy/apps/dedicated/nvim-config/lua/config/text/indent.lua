---@type ConfigModule
local module = {
  pkgs = {
    {
      'lukas-reineke/indent-blankline.nvim',
      config = function()
        require('ibl').setup {
          scope = {
            enabled = false,
          },
        }
      end,
    },
  },
}

return module
