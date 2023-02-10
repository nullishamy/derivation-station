return {
  name = 'lua',

  lsp = {
    {
    },
  },

  format = {
    filetype = 'lua',
    runners = {
      require('formatter.filetypes.lua').stylua,
    },
  },
}
