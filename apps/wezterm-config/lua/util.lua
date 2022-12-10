local util = {}

function util.apply(cfg, values, mod)
  local ok, res = pcall(require, 'lua.' .. mod)

  if not ok then
    -- die idk
    print(res)
    return
  end

  ok, res = pcall(res, cfg, values, require('wezterm'))

  if not ok then
    -- die idk
    print(res)
    return
  end
end

return util
