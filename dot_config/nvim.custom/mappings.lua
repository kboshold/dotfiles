---@type MappingsTable
local M = {}

M.general = {
  n = {
    ["<leader>te"] = { "<CMD>Translate EN<CR>", "Translate selection to englisch", { nowait = true}},
    ["<leader>tg"] = { "<CMD>Translate DE<CR>", "Translate selection to german", { nowait = true}},
    ["<leader>gg"] = { "<CMD>LazyGit<CR>", "Open LazyGit", { nowait = true }}
  },
}

return M
