local M = {}

function M.fetch_key_list()
  local url = "https://keys.makandra.de/ssh/"
  local handle = io.popen("curl -s " .. vim.fn.shellescape(url))
  if not handle then return {} end

  local content = handle:read("*a")
  handle:close()

  local keys = {}
  for filename in content:gmatch('href="([^"]+%.pub)"') do
    table.insert(keys, filename:gsub("%.pub$", ""))
  end

  return keys
end

function M.insert_key(username)
  local url = "https://keys.makandra.de/ssh/" .. username .. ".pub"
  local handle = io.popen("curl -s " .. vim.fn.shellescape(url))
  if not handle then
    vim.notify("Fehler beim Abrufen der URL: " .. url, vim.log.levels.ERROR)
    return
  end
  local content = handle:read("*a")
  handle:close()

  if content:match("^%s*<html>") then
    vim.notify("Fehler: Username '" .. username .. "' ist vermutlich nicht korrekt.", vim.log.levels.ERROR)
    return
  end

  local parts = vim.split(content, "%s+")
  if #parts >= 2 then
    local key = parts[1] .. " " .. parts[2]
    vim.api.nvim_put({ key }, "", true, true)
  else
    vim.notify("Ungültiges Format für " .. username, vim.log.levels.ERROR)
  end
end

return M
