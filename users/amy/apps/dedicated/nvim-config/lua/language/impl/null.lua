local language, server = unpack(require('language.dsl'))

return language {
  name = 'null-ls',

  server.external {
    setup = function(module)
      local ns = require('null-ls').builtins

      require('null-ls').setup {
        sources = {
          ns.diagnostics.gitlint,
          ns.diagnostics.selene,
          ns.diagnostics.statix,

          ns.code_actions.statix,
          ns.code_actions.gitrebase,
          ns.code_actions.proselint,

          ns.hover.printenv,
        },
        update_in_insert = true,
        on_attach = require('language.misc.on_attach')(module),
      }
    end,
  },
}
