local data = require('custom.data')

local plugins = {


  -- this opts will extend the default opts 
  {
    "nvim-treesitter/nvim-treesitter",
       autotag = {
        enable = true,
        filetypes = { "html", "tsx", "xml" },
      },
    opts = {
      ensure_installed = {"html", "css", "bash", "typescript", "yaml", "dockerfile", "javascript", "tsx", "json", "xml"},
    },
  },

  {
      'windwp/nvim-autopairs',
      event = "InsertEnter",
      opts = {} -- this is equalent to setup({}) function
  },

  {
    "windwp/nvim-ts-autotag",
    config = function()
      require("nvim-ts-autotag").setup {
        filetypes = { "html", "tsx" },
      }
    end,
  },

  {
    "uga-rosa/translate.nvim",
    cmd = { "Translate" },
    opts = function()
      vim.g.deepl_api_auth_key = data.deeplApiKey
      return {
        default = {
          command = "deepl_free",
          output = "replace",
        },
      }
    end
  },

  {
    "neovim/nvim-lspconfig",
     config = function()
        require "plugins.configs.lspconfig"
        require "custom.configs.lspconfig"
     end,
  },

   {
   "williamboman/mason.nvim",
   opts = {
      ensure_installed = {
        "lua-language-server",
        "html-lsp",
        "prettier",
        "stylua",
        "angular-language-server",
        "eslint-lsp",
        "lua-language-server",
        "typescript-language-server",
      },
    },
  }
}

return plugins
