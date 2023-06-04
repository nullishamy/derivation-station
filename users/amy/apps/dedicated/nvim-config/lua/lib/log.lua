local log = {}

function log.info(...)
  vim.print(('INFO(config) - %s'):format(table.concat({ ... }, ' ')))
end

function log.warn(...)
  vim.print(('WARN(config) - %s'):format(table.concat({ ... }, ' ')))
end

function log.error(...)
  vim.print(('ERROR(config) - %s'):format(table.concat({ ... }, ' ')))
end

return log
