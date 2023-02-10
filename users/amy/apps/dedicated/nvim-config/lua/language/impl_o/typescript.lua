return {
  name = 'typescript',

  lsp = {
    {
      key = 'tsserver',
    },
  },

  format = {
    filetype = { 'typescript', 'javascript', 'typescriptreact' },
    runners = {
      require('formatter.filetypes.typescript').prettier,
    },
  },
}
