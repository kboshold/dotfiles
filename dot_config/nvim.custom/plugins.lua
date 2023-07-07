local plugins = {


  -- this opts will extend the default opts 
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {"html", "css", "bash"},
    },
  },

  {
    "uga-rosa/translate.nvim"
  }

}

return plugins