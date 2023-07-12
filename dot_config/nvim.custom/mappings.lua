---@type MappingsTable
local M = {}

M.general = {
  n = {
    ["<leader>te"] = { "<CMD>Translate EN<CR>", "Translate selection to englisch", { nowait = true}},
    ["<leader>tg"] = { "<CMD>Translate DE<CR>", "Translate selection to german", { nowait = true}},
    ["<leader>gg"] = { "<CMD>LazyGitToggle<CR>", "Open LazyGit"},
    ["<leader>dd"] = { "<CMD>LazyDockerToggle<CR>", "Open LazyDocker"},
  },
  v = {
    ["<leader>te"] = { "<CMD>'<,'>Translate EN<CR>", "Translate selection to englisch", { nowait = true}},
    ["<leader>tg"] = { "<CMD>'<,'>Translate DE<CR>", "Translate selection to german", { nowait = true}},
  }
}

return M
