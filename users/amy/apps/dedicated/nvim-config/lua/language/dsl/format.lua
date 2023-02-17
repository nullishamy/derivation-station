local util = require('language.dsl.util')

local __formatter = {
  null = function(tbl)
    return {
      type = 'formatter',
      configure_with = 'null-ls',
      source = tbl.config and tbl.runner.with(tbl.config) or tbl.runner,
    }
  end,
  -- For use with formatter.null
  -- NOTE: https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/HELPERS.md#generator_factory
  -- Examples: https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins
  nullc = function (tbl)
    return require('null-ls.helpers').generator_factory(tbl)
  end,
  disabled = function()
    return {
      type = 'disabled',
    }
  end,
  lsp = function(tbl)
    return {
      type = 'formatter',
      configure_with = 'lsp',
      declared_config = tbl,
      overrides = tbl.config,
    }
  end,
  runner = require('null-ls').builtins.formatting,
}

local formatter = util.callable(__formatter, __formatter.null)

return formatter
