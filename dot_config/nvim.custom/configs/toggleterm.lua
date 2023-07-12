local M = {}
local toggleterm = require "toggleterm"
local Terminal = require("toggleterm.terminal").Terminal

-- LazyDocker
local lazydocker_client = Terminal:new {
  cmd = "lazydocker",
  dir = "git_dir",
  hidden = true,
  direction = "float",
  float_opts = {
    border = "double",
  },
}

function M.lazydocker_client_toggle()
  lazydocker_client:toggle()
end

-- LazyGit
local lazygit_client = Terminal:new {
  cmd = "lazygit",
  dir = "git_dir",
  hidden = true,
  direction = "float",
  float_opts = {
    border = "double",
  },
}

function M.lazygit_client_toggle()
  lazygit_client:toggle()
end

vim.api.nvim_add_user_command("LazyGitToggle", M.lazygit_client_toggle)
vim.api.nvim_add_user_command("LazyDockerToggle", M.lazydocker_client_toggle)

return M
