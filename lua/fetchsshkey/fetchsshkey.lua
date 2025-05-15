local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local fetch = require("fetchsshkey.fetch")

local M = {}

function M.pick_and_insert_key()
  local keys = fetch.fetch_key_list()
  if vim.tbl_isempty(keys) then
    vim.notify("Keine SSH Keys gefunden.", vim.log.levels.WARN)
    return
  end

  pickers.new({}, {
    prompt_title = "Wähle SSH Key",
    finder = finders.new_table { results = keys },
    sorter = conf.generic_sorter({}),
    attach_mappings = function(prompt_bufnr, map)
      actions.select_default:replace(function()
        actions.close(prompt_bufnr)
        local selection = action_state.get_selected_entry()
        fetch.insert_key(selection[1])
      end)
      return true
    end,
  }):find()
end

return M
