return function(cfg, values)
  cfg.color_scheme = values.scheme
  cfg.colors = {}

  cfg.colors.tab_bar = {
    background = '#1e1e2e',
    active_tab = {
      bg_color = '#36374a',
      fg_color = '#cdd6f4',
      intensity = 'Normal',
      italic = false,
      strikethrough = false,
      underline = 'None',
    },
    inactive_tab = {
      bg_color = '#181825',
      fg_color = '#cdd6f4',
      intensity = 'Normal',
      italic = false,
      strikethrough = false,
      underline = 'None',
    },
    inactive_tab_edge = 'none',
    inactive_tab_edge_hover = '#363636',
    inactive_tab_hover = {
      bg_color = '#181825',
      fg_color = '#cdd6f4',
      intensity = 'Normal',
      italic = false,
      strikethrough = false,
      underline = 'None',
    },
    new_tab = {
      bg_color = '#1e1e2e',
      fg_color = '#cdd6f4',
      intensity = 'Normal',
      italic = false,
      strikethrough = false,
      underline = 'None',
    },
    new_tab_hover = {
      bg_color = '#181825',
      fg_color = '#cdd6f4',
      intensity = 'Normal',
      italic = true,
      strikethrough = false,
      underline = 'None',
    },
  }
end
