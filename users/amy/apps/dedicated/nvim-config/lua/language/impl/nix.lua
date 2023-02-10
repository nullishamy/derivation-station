local language, server, formatter = unpack(require('language.dsl'))

return language {
  name = 'nix',

  server.configured {
    name = 'rnix',
  },

  -- FIXME: Implement once we have exe running
  formatter.disabled {
    runners = {
      function()
        return {
          exe = 'nixpkgs-fmt',
          stdin = true,
          args = {
          },
        }
      end,
    },
  }
}
