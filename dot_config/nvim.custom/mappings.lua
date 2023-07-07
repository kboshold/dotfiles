---@type MappingsTable
local M = {}

M.general = {
  v = {
    ["<leader>te"] = { ":Translate EN", "Translate selection to englisch", { nowait = true}},
    ["<leader>tg"] = { ":Translate DE", "Translate selection to german", { nowait = true}}
  },
}

return M