---@type ConfigModule
local module = {
  pkgs = {
    {
      'coffebar/neovim-project',
      commit = '2daa3f02a91d36efba692cf032b1f3cc2c66e2c2',
      config = function()
        --require('session_manager').setup({})
        require('neovim-project').setup {
          projects = {
            '~/code/public/small/*',
            '~/code/public/medium/*',
            '~/code/public/large/*',
            '~/code/public/oss/*',
            '~/nixos',
          },
          picker = {
            type = 'telescope',
          },
        }
      end,
      dependencies = {
        { 'Shatur/neovim-session-manager', commit = 'a0b9d25154be573bc0f99877afb3f57cf881cce7' },
      },
    },
  },
}

return module
