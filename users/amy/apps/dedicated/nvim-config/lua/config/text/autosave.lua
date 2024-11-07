---@type ConfigModule
local module = {
  pkgs = {
    {
      'nullishamy/autosave.nvim',
      config = function()
        require('autosave').setup {}
      end,
    },
  },
}

return module
