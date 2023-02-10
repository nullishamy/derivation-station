local util = require('language.dsl.util')

local __formatter = {
  null = function (tbl)
    return {
      type = 'formatter',
      configure_with = 'null-ls',
      source = tbl.config and tbl.runner.with(tbl.config) or tbl.runner
    }
  end,
  disabled = function ()
    return {
      type = 'disabled',
    }
  end,
  lsp = function (tbl)
    return {
      type = 'formatter',
      configure_with = 'lsp',
      declared_config = tbl,
      overrides = tbl.config,
    }
  end,
  runner = require('null-ls').builtins.formatting
}

local formatter = util.callable(__formatter, __formatter.null)

return formatter
