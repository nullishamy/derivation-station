local language, server, formatter = unpack(require('language.dsl'))

return language {
  name = 'python',

  server.configured {
    name = 'pyright',
  },

  formatter.null {
    runner = formatter.runner.black,
  },
}
