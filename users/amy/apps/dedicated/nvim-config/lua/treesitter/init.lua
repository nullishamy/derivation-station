return {
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
      ensure_installed = require('treesitter.ensure_installed'),
      rainbow = require('treesitter.rainbow_brackets'),
      textobjects = require('treesitter.textobjects'),
      incremental_selection = require('treesitter.incremental_selection'),
      plaground = require('treesitter.playground'),
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
}
