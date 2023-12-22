local M = {}

function M.deep_merge(into, from)
  for k, v in pairs(from) do
    if type(v) == 'table' and type(into[k]) == 'table' then
      M.deep_merge(into[k], v)
    else
      into[k] = v
    end
  end
end

return M
