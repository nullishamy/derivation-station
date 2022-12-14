local wez = require('wezterm')
local util = require('lua.util')

local config = {}

local values = {
  font = wez.font({
    family = 'VictorMono Nerd Font Mono',
    stretch = 'Normal',
    weight = 'Medium',
  }),
  font_size = 13.0,
  scheme = 'Catppuccin Mocha',
  theme = wez.color.get_builtin_schemes()['Catppuccin Mocha']
}

util.apply(config, values, 'base')
util.apply(config, values, 'keys')
util.apply(config, values, 'font')
util.apply(config, values, 'colors')

return config
