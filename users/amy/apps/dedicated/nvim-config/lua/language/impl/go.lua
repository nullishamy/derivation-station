local language, server, _ = unpack(require('language.dsl'))

return language {
  name = 'go',

  server.configured {
    name = 'gopls',
  },
}
