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
  on_open = function(term)
    vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", {noremap = true, silent = true})
    vim.api.nvim_buf_set_keymap(term.bufnr, "n", "<ESC>", "<cmd>close<CR>", {noremap = true, silent = true})
  end,
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
  on_open = function(term)
    vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", {noremap = true, silent = true})
    vim.api.nvim_buf_set_keymap(term.bufnr, "n", "<ESC>", "<cmd>close<CR>", {noremap = true, silent = true})
  end,
}

vim.api.nvim_create_user_command("LazyGitToggle", function()
    lazygit_client:toggle()
end, {})

vim.api.nvim_create_user_command("LazyDockerToggle", function()
  lazydocker_client:toggle()
end, {})
