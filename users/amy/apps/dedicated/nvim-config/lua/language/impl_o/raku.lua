return {
  name = 'raku',

  lsp = {
    -- Table of servers, will all be executed
    {
      key = 'raku_navigator',
      config = {
        cmd = { 'raku-navigator', '--stdio' },
        filetypes = { 'raku', 'perl' },
      },
    },
  },

  format = {
    -- nil/true signifies enabled, false signifies disabled
    enable = false,
    -- Can be a table too, will run on all types given
    filetype = 'filetype-to-format',
    runners = {
      -- Formatter runners
      -- require('formatter.filetypes.<filetype>').formatter,
    },
  },
}
