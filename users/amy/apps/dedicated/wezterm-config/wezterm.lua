local wez = require('wezterm')
local util = require('lua.util')

local config = {}

local values = {
  scheme = 'Catppuccin Mocha',
  theme = wez.color.get_builtin_schemes()['Catppuccin Mocha'],
  italic_enable = false,
}

util.apply(config, values, 'base')
util.apply(config, values, 'font')
util.apply(config, values, 'keys')
util.apply(config, values, 'bar')
util.apply(config, values, 'colors')

return config
