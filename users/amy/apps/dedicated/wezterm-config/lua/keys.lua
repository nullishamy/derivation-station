return function(cfg, _, wez)
  local act = wez.action

  cfg.leader = {
    key = 's',
    mods = 'CTRL',
    timeout_milliseconds = 2500,
  }

  cfg.debug_key_events = true
  cfg.disable_default_key_bindings = true

  cfg.keys = {
    -- Wez control
    { key = 'r', mods = 'LEADER', action = act.ReloadConfiguration },
    { key = 'd', mods = 'LEADER', action = act.ShowDebugOverlay },

    -- FIXME: Activate once we get the update (https://wezfurlong.org/wezterm/config/lua/keyassignment/ResetTerminal.html)
    -- { key = 's', mods = 'LEADER', action = act.ResetTerminal },

    { key = 'Space', mods = 'LEADER', action = act.ShowLauncher },

    { key = 'l', mods = 'CTRL', action = act.ActivateTabRelative(1) },
    { key = 'h', mods = 'CTRL', action = act.ActivateTabRelative(-1) },

    -- Tab control
    { key = '1', mods = 'CTRL', action = act { ActivateTab = 0 } },
    { key = '2', mods = 'CTRL', action = act { ActivateTab = 1 } },
    { key = '3', mods = 'CTRL', action = act { ActivateTab = 2 } },
    { key = '4', mods = 'CTRL', action = act { ActivateTab = 3 } },
    { key = '5', mods = 'CTRL', action = act { ActivateTab = 4 } },
    { key = '6', mods = 'CTRL', action = act { ActivateTab = 5 } },
    { key = '7', mods = 'CTRL', action = act { ActivateTab = 6 } },
    { key = '8', mods = 'CTRL', action = act { ActivateTab = 7 } },
    { key = '9', mods = 'CTRL', action = act { ActivateTab = 8 } },
    { key = '9', mods = 'CTRL', action = act { ActivateTab = 9 } },
    { key = '0', mods = 'CTRL', action = act { ActivateTab = -1 } },

    { key = 'n', mods = 'SHIFT|CTRL', action = act.SpawnWindow },
    { key = 't', mods = 'SHIFT|CTRL', action = act.SpawnTab('CurrentPaneDomain') },

    { key = 'c', mods = 'SHIFT|CTRL', action = act.CopyTo('Clipboard') },
    { key = 'v', mods = 'SHIFT|CTRL', action = act.PasteFrom('Clipboard') },

    { key = 'w', mods = 'SHIFT|CTRL', action = act.CloseCurrentTab { confirm = true } },
  }
end
