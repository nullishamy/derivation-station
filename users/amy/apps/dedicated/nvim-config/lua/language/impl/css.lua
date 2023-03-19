local language, server, _ = unpack(require('language.dsl'))

return language {
  name = 'css',

  server.configured {
    name = 'cssls',
  },

  server.configured {
    name = 'tailwindcss',
  },
}
