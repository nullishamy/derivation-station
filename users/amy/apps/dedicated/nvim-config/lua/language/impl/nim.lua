local language, server, _ = unpack(require('language.dsl'))

return language {
  name = 'nim',

  server.configured {
    name = 'nimls',
  },
}
