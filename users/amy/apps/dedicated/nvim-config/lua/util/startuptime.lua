return {
  'tweekmonster/startuptime.vim',
  cond = function()
    return require('config').startuptime.enabled
  end,
}
