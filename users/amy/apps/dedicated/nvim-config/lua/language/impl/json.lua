local language, server, formatter = unpack(require('language.dsl'))

return language {
  name = 'json',

  server.configured {
    name = 'jsonls',
  },

  formatter.null {
    runner = formatter.runner.prettier,
  },
}
