local language, server, formatter = unpack(require('language.dsl'))

return language {
  name = 'json',

  server.configured {
    name = 'jsonls',
    config = {
      cmd = { 'vscode-json-languageserver', '--stdio' },
      settings = {
        json = {
          schemas = require('schemastore').json.schemas(),
          validate = { enable = true },
        },
      },
    },
  },

  formatter.null {
    runner = formatter.runner.prettier,
  },
}
