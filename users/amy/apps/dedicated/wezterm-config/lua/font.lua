local wez = require('wezterm')

local fonts = {
  berkeley = {
    font = wez.font_with_fallback {
      {
        family = 'Berkeley Mono',
        stretch = 'Normal',
        weight = 'Medium',
      },
    },
    size = 12,
    cell_width = 0.9,
  },
  fantasque = {
    font = wez.font_with_fallback {
      {
        family = 'FantasqueSansMono Nerd Font',
        stretch = 'Normal',
        weight = 'Medium',
      },
    },
    size = 13.0,
  },
  iosevka = {
    font = wez.font_with_fallback {
      {
        family = 'Iosevka Nerd Font',
        stretch = 'Normal',
        weight = 'Regular',
      },
      size = 11.0,
    },
  },
}

local selected_font = 'iosevka'

return function(cfg, values)
  cfg.font = fonts[selected_font].font
  cfg.font_size = fonts[selected_font].size
  cfg.cell_width = fonts[selected_font].cell_width or 1

  if values.italic_enable then
    cfg.font_rules = {
      -- Disable italics everywhere
      -- Use regular bold instead of italic bold
      {
        italic = true,
        font = cfg.font,
      },
      {
        italic = false,
        intensity = 'Bold',
        font = wez.font {
          family = cfg.font.family,
          stretch = 'Normal',
          weight = 'Bold',
        },
      },
    }
  end
end
