local language, server, formatter = unpack(require('language.dsl'))

return language {
  name = 'bash',

  server.configured {
    name = 'bashls',
  },

  formatter.disabled {
    runner = formatter.runner.beautysh,
  },
}
