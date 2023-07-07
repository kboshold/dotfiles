local data = require('custom.data')

local plugins = {


  -- this opts will extend the default opts 
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {"html", "css", "bash"},
    },
  },

  {
    "uga-rosa/translate.nvim",
    opts = function()
      vim.g.deepl_api_auth_key = data.deeplApiKey
      return {
        default = {
          command = "deepl_free",
        },
        preset = {
            output = {
                split = {
                    append = true,
                },
            },
        },
      }
    end
  }

}

return plugins