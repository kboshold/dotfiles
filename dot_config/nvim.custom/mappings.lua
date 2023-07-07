---@type MappingsTable
local M = {}

M.general = {
  n = {
    ["<leader>te"] = { function() require("translate").translate("EN", {"-command=deepl_free"}) end, "Translate selection to englisch", { nowait = true}},
    ["<leader>tg"] = { function() require("translate").translate("DE", {"-command=deepl_free"}) end, "Translate selection to german", { nowait = true}}
  },
}

return M