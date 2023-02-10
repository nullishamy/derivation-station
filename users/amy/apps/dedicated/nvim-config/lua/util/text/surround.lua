return {
  'kylechui/nvim-surround',
  config = function()
    require('nvim-surround').setup({
      -- FIXME: Fix conflict with leap
      move_cursor = false,
    })
  end,
}
