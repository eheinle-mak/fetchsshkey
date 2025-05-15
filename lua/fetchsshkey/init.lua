local M = {}

M.pick_and_insert_key = function()
  require("fetchsshkey.fetchsshkey").pick_and_insert_key()
end

vim.api.nvim_create_user_command("FetchSSHKey", function()
  M.pick_and_insert_key()
end, {})

return M
