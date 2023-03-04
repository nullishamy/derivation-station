local language, server, _ = unpack(require('language.dsl'))

return language {
  name = 'docker',

  server.configured {
    name = 'dockerls',
  },
}
