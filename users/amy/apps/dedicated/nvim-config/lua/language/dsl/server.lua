local util = require('language.dsl.util')

local __server = {
  configured = function (tbl)
    return {
      type = 'server',
      configure_with = 'lspconfig',
      pre = tbl.pre or util.noop,
      overrides = tbl.config or util.etable,
      declared_config = tbl,
      after = tbl.after or util.noop,
    }
  end,
  disabled = function ()
    return {
      type = 'disabled',
    }
  end,
  external = function (tbl)
    return {
      type = 'server',
      configure_with = 'external',
      setup = tbl.setup
    }
  end
}

local server = util.callable(__server, __server.configured)

return server
