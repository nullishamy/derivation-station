return function(cfg, values)
  cfg.window_frame = {
    active_titlebar_bg = values.theme.background,
    inactive_titlebar_bg = values.theme.background,
    font = values.font,
    font_size = 12.0,
  }

  cfg.max_fps = 144
  cfg.audible_bell = 'Disabled'
  cfg.debug_key_events = true

  -- Disable the shell
  cfg.default_cursor_style = 'SteadyBar'
  cfg.cursor_blink_rate = 0

  -- Use nushell for wezterm
  cfg.default_prog = { 'nu' }

  cfg.warn_about_missing_glyphs = false
end
