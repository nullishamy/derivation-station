local language, server, formatter = unpack(require('language.dsl'))

return language {
  name = 'rust',

  server.configured {
    name = 'rust_analyzer',
    after = function(module)
      require('rust-tools').setup {
        server = {
          autostart = true,
          on_attach = require('language.misc.on_attach')(module),
          capabilities = require('language.misc.capabilities'),
        },
        tools = {
          inlay_hints = {
            auto = false,
          },
        },
      }
    end,
  },

  formatter.null {
    runner = formatter.runner.rustfmt,
  },
}
