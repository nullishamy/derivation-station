return function(cfg, values)
  cfg.window_frame = {
    active_titlebar_bg = values.theme.background,
    inactive_titlebar_bg = values.theme.background,
    font = values.font,
    font_size = 12.0,
  }
  cfg.enable_scroll_bar = true
  cfg.max_fps = 144

  -- cfg.use_fancy_tab_bar = false
  cfg.enable_scroll_bar = false
  cfg.hide_tab_bar_if_only_one_tab = true
  cfg.audible_bell = 'Disabled'
  cfg.debug_key_events = true
  cfg.default_cursor_style = 'SteadyBar'
end
