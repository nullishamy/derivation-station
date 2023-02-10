return {
  name = 'null-ls',

  lsp = {
    {
      key = 'null-ls',
      config = {
        external_setup = function(config)
          local ns = require('null-ls').builtins

        end,
      },
    },
  },

  format = {
    -- null-ls will never have formatters
    enable = false,
  },
}
