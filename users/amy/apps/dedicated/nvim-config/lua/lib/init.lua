local log = require('lib.log')
local lib = {}

function lib.load_module(path, state)
  local ok, result = pcall(require, path)

  if not ok then
    log.error('failed to load module', path, '\n', result)
    return
  end

  if type(result) ~= 'table' then
    log.error('result from', path, 'was not a table, got', tostring(result))
    return
  end

  ---@type ConfigModule
  local module = result
  if module.hooks and module.hooks.pre_init then
    module.hooks.pre_init(state)
  end

  if module.enable == false then
    log.info('disabled module ', path)
    return
  end

  if type(module.pkgs) == 'table' then
    for _, value in ipairs(module.pkgs) do
      table.insert(state.pkgs, value)
    end
  end

  if module.hooks and module.hooks.init then
    module.hooks.init(state)
  end

  if module.hooks and module.hooks.post_init then
    module.hooks.post_init(state)
  end
end

function lib.modules(module_list)
  local state = {
    pkgs = {},
  }

  for _, value in ipairs(module_list) do
    lib.load_module(('config.%s'):format(value), state)
  end
end

return lib
