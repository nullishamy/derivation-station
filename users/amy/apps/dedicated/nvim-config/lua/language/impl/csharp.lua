local language, server, formatter = unpack(require('language.dsl'))
local pid = vim.fn.getpid()

return language {
  name = 'c#',

  server.configured {
    name = 'omnisharp',
    config = {
      cmd = { 'omnisharp', '--languageserver', '--hostPID', tostring(pid) },
    },
  },

  -- FIXME: Install clang_format
  formatter.disabled {
    runner = formatter.runner.clang_format,
  },
}
