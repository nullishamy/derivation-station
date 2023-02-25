return {
  'nullishamy/autosave.nvim',
  config = function()
    require('autosave').setup {}
  end,
  dependencies = {
    { 'nvim-lua/plenary.nvim' },
  }
}
