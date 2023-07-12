local autocmd = vim.api.nvim_create_autocmd
local toggleterm = require "toggleterm"
local Terminal = require("toggleterm.terminal").Terminal

toggleterm.setup()

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

autocmd("LazyGitToggle", {
  callback = function()
    lazygit_client:toggle()
  end
})

autocmd("LazyDockerToggle", {
  callback = function()
    lazydocker_client:toggle()
  end
})
