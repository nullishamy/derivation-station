local wez = require('wezterm')
local util = require('lua.util')

local config = {
  italic_enable = false
}

local values = {
  font = wez.font({
    family = 'Berkeley Mono',
    stretch = 'Normal',
    weight = 'Medium',
  }),
  font_size = 12.0,
  scheme = 'Catppuccin Mocha',
  theme = wez.color.get_builtin_schemes()['Catppuccin Mocha']
}

util.apply(config, values, 'base')
util.apply(config, values, 'keys')
util.apply(config, values, 'font')
util.apply(config, values, 'bar')
util.apply(config, values, 'colors')

return config
