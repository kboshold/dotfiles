---@type MappingsTable
local M = {}

M.general = {
  v = {
    ["<leader>te"] = { function() require("translate").translate(vim.fn.visualmode(), {"EN"}) end, "Translate selection to englisch", { nowait = true}},
    ["<leader>tg"] = { function() require("translate").translate(vim.fn.visualmode(), {"DE"}) end, "Translate selection to german", { nowait = true}}
  },
}

return M