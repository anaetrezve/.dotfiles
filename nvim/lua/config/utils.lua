local M = {}

-- Utility to add blank lines/spaces
M.add_padding = function(lines, top, bottom, left, right)
  local t = {}
  for _ = 1, top do
    table.insert(t, "")
  end
  for _, line in ipairs(lines) do
    table.insert(t, (" "):rep(left) .. line .. (" "):rep(right))
  end
  for _ = 1, bottom do
    table.insert(t, "")
  end
  return t
end

-- Normalize input and remove empty surrounding lines
M.normalize = function(lines)
  local str = table.concat(lines, "\n")
  return vim.split(str, "\n", { trimempty = true })
end

return M
