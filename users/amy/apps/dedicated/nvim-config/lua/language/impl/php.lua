local language, server, _ = unpack(require('language.dsl'))

return language {
  name = 'php',

  server.configured {
    name = 'intelephense',
  },
}
