local language, server, formatter = unpack(require('language.dsl'))

return language {
  name = 'typescript',

  server.configured {
    name = 'tsserver',
  },

  formatter.null {
    runner = formatter.runner.prettier,
  },
}
