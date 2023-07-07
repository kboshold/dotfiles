---@type MappingsTable
local M = {}

M.general = {
  v = {
    ["<leader>te"] = { "<CMD>Translate EN<CR>", "Translate selection to englisch", { nowait = true}},
    ["<leader>tg"] = { "<CMD>Translate DE<CR>", "Translate selection to german", { nowait = true}}
  },
}

return M