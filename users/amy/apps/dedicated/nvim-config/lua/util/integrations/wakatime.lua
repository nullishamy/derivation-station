return {
  'wakatime/vim-wakatime',
  cond = function()
    return require('config').wakatime.enabled
  end,
}
