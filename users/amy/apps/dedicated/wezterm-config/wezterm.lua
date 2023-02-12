local wez = require('wezterm')
local util = require('lua.util')

local config = {
  italic_enable = false
}

local fonts = {
  berkeley = {
    font = wez.font({
      family = 'Berkeley Mono',
      stretch = 'Normal',
      weight = 'Medium',
      cell_width = 0.8
    }),
    size = 11.8
  },
  fantasque = {
    font = wez.font({
      family = 'FantasqueSansMono Nerd Font',
      stretch = 'Normal',
      weight = 'Medium',
    }),
    size = 13.0
  },
  iosevka = {
    font = wez.font({
      family = 'Iosevka',
      stretch = 'Normal',
      weight = 'Medium',
    }),
    size = 12.0
  },
}

local values = {
  font = fonts['berkeley'].font,
  font_size = fonts['berkeley'].size,
  scheme = 'Catppuccin Mocha',
  theme = wez.color.get_builtin_schemes()['Catppuccin Mocha']
}

util.apply(config, values, 'base')
util.apply(config, values, 'keys')
util.apply(config, values, 'font')
util.apply(config, values, 'bar')
util.apply(config, values, 'colors')

return config
