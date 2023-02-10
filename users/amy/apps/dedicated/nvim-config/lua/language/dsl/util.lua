local util = {}

function util.callable(tbl, on_call)
  return setmetatable(tbl, {
    __call = on_call
  })
end

function util.noop() end
util.etable = {}

return util
