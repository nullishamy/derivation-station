---@type ConfigModule
local module = {
  pkgs = {
    {
      'numToStr/Comment.nvim',
      config = function()
        require('Comment').setup {}
      end,
    },
  },
}

return module
