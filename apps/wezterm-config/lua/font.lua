return function(cfg, values, wez)
  cfg.font = values.font
  cfg.font_size = values.font_size
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
        family = 'VictorMono Nerd Font Mono',
        stretch = 'Normal',
        weight = 'Bold',
      }),
    },
  }
end
