local wez = require('wezterm')

local fonts = {
  berkeley = {
    font = wez.font({
      family = 'Berkeley Mono',
      stretch = 'Normal',
      weight = 'Medium',
      cell_width = 0.8,
    }),
    size = 11.8,
  },
  fantasque = {
    font = wez.font({
      family = 'FantasqueSansMono Nerd Font',
      stretch = 'Normal',
      weight = 'Medium',
    }),
    size = 13.0,
  },
  iosevka = {
    font = wez.font({
      family = 'Iosevka',
      stretch = 'Normal',
      weight = 'Medium',
    }),
    size = 12.0,
  },
}

local selected_font = 'berkeley'

return function(cfg)
  cfg.font = fonts[selected_font].font
  cfg.font_size = fonts[selected_font].size

  if cfg.italic_enable then
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
        font = wez.font({
          family = cfg.font.family,
          stretch = 'Normal',
          weight = 'Bold',
        }),
      },
    }
  end
end
