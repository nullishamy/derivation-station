local language, server, formatter = unpack(require('language.dsl'))

return language {
  name = 'nix',

  server.configured {
    name = 'rnix',
  },

  formatter.null {
    runner = formatter.runner.alejandra,
  },
}
