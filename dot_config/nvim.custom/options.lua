vim.opt.guicursor = ""
vim.opt.nu = true
vim.opt.relativenumber = true


vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.cache/nvim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50
vim.opt.shortmess:append("I")

vim.opt.listchars = {
  eol = '',
  space = '·',
  tab = ' '
}
vim.opt.list = true
