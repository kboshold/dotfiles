---@type MappingsTable
local M = {}

M.general = {
  v = {
    ["<leader>te"] = { function() require("translate").translate(vim.fn.mode() or vim.fn.visualmode(), {"EN", "-command=deepl_free"}) end, "Translate selection to englisch", { nowait = true}},
    ["<leader>tg"] = { function() require("translate").translate(vim.fn.mode() or vim.fn.visualmode(), {"DE", "-command=deepl_free"}) end, "Translate selection to german", { nowait = true}}
  },
}

return M