local module = {
  pkgs = {
    {
      'nvim-treesitter/nvim-treesitter',
      config = function()
        require('nvim-treesitter.configs').setup {
          highlight = {
            enable = true,
          },
          indent = {
            enable = true,
          },
          autotag = {
            enable = true,
          },
          ensure_installed = require('config.treesitter.ensure_installed'),
          rainbow = require('config.treesitter.rainbow_brackets'),
          textobjects = require('config.treesitter.textobjects'),
          incremental_selection = require('config.treesitter.incremental_selection'),
          plaground = require('config.treesitter.playground'),
        }
      end,
      build = ':TSUpdate',
      dependencies = {
        { 'nvim-treesitter/nvim-treesitter-textobjects' },
        { 'p00f/nvim-ts-rainbow' },
        { 'windwp/nvim-ts-autotag' },
        { 'windwp/nvim-autopairs' },
        { 'nvim-treesitter/playground' },
      },
    },
  },
}

return module
