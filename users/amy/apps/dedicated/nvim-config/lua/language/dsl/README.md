# Language DSL

## Layout
   ┌───────────┐
   │ DSL Decls │
   └─────┬─────┘
         │
         │
    ┌────▼────┐
    │Transform│
    │Add data │
    └────┬────┘
         │
         │
    ┌────▼────┐
    │Apply to │
    │plugins  │
    └─────────┘

## Examples

```lua
-- Required, must be declared in this order
local language, server, formatter = unpack(require('language.dsl'))

-- Beginning of language declaration, takes exactly one argument
return language {
  name = 'json', -- The display name of the language

  -- A configured language server, setup by lspconfig
  server.configured {
    name = 'jsonls', -- The key to index into lspconfig
    config = {}      -- The config to pass to lspconfig => to the LSP
  },

  -- A configured formatter, setup with null-ls
  formatter.null {
    runner = formatter.runner.prettier, -- The runner to use, `formatter.runner.__index` indexes into null-ls' formatters
                                        -- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#formatting
  },
}
```

Same as before, with a custom setup flow
```lua
local language, server = unpack(require('language.dsl'))

return language {
  name = 'null-ls',

  -- A configured language server, setup with an external source
  server.external {
    setup = function(module) -- The function to setup with, gets the current module as its argument
      local ns = require('null-ls').builtins

      require('null-ls').setup {
        sources = {
          ns.diagnostics.gitlint,
          ns.diagnostics.selene,
          ns.diagnostics.statix,

          ns.code_actions.statix,
          ns.code_actions.gitrebase,
          ns.code_actions.proselint,
        },
        update_in_insert = true,
        on_attach = require('language.misc.on_attach')(module),
      }
    end,
  },
}
```


