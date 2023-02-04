return function(cfg, values, wez)
  cfg.font = values.font
  cfg.font_size = values.font_size

  if cfg.italic_enable then
    cfg.font_rules = {
      -- Disable italics everywhere
      -- Use regular bold instead of italic bold
      {
        italic = true,
        font = values.font,
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
