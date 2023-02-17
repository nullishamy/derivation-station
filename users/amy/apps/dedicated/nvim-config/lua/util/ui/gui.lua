return {
  'stevearc/dressing.nvim',
  config = function()
    require('dressing').setup {
      input = {
        win_options = {
          winblend = 0,
        },
      },
      select = {
        winblend = 0,
        nui = {
          win_options = {
            winblend = 0,
          },
        },
      },
      builtin = {
        winblend = 0,
      },
    }
  end,
}
