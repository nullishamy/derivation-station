local language, server, formatter = unpack(require('language.dsl'))

return language {
  name = 'c++',

  server.configured {
    name = 'clangd',
  },

  -- FIXME: Install clang_format
  formatter.disabled {
    runner = formatter.runner.clang_format,
  },
}
