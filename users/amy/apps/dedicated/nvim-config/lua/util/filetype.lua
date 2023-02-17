return {
  'nathom/filetype.nvim',
  config = function()
    require('filetype').setup {
      overrides = {
        extensions = {
          cs = 'c_sharp',
          zeppelin = 'zeppelin',
          markdown = 'markdown',
          sh = 'sh',
          c = 'c',
          wp = 'sh',
        },
        literal = {
          justfile = 'make',
        },
      },
    }
  end,
}
