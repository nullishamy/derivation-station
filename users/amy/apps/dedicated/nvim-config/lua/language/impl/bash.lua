local language, server, formatter = unpack(require('language.dsl'))

return language {
  name = 'bash',

  server.configured {
    name = 'bashls',
  },

  -- FIXME: Install beautysh
  formatter.disabled {
    runner = formatter.runner.beautysh,
  },
}
