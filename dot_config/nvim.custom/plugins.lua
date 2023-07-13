local data = require("custom.data")

local plugins = {
    {
    "mfussenegger/nvim-dap",
    dependencies = {
      {
        "theHamsta/nvim-dap-virtual-text",
        config = function()
          require "custom.configs.virtual-text"
        end,
      },
      {
        "rcarriga/nvim-dap-ui",
        config = function()
          require "custom.configs.dapui"
        end,
      },
    },
  },
     {
    "nvim-treesitter/nvim-treesitter-context",
    event = "BufWinEnter",
    config = function()
      require "custom.configs.context"
    end,
  },
     {
    "lukas-reineke/virt-column.nvim",
    event = "BufReadPost",
    config = function()
      require("virt-column").setup {
        char = "┃",
        virtcolumn = "120",
      }
    end,
  },
      {
    "rest-nvim/rest.nvim",
    ft = { "http" },
    config = function()
      require("rest-nvim").setup {
        result_split_horizontal = true,
      }
    end,
  },
    {
    "zbirenbaum/neodim",
    event = "LspAttach",
    branch = "v2",
    config = function()
      require("neodim").setup {
        refresh_delay = 75,
        alpha = 0.75,
        blend_color = "#000000",
        hide = { underline = true, virtual_text = true, signs = true },
        priority = 150,
        disable = {},
      }
    end,
  },
    {
    "sindrets/diffview.nvim",
    cmd = "DiffviewOpen",
    config = function()
      require("diffview").setup {
        enhanced_diff_hl = true,
        view = {
          merge_tool = {
            layout = "diff3_mixed",
            disable_diagnostics = true,
          },
        },
      }
    end,
  },
    {
        "mbbill/undotree",
        cmd = { "UndotreeToggle" },
        opts = {}
    },
    {
        "melkster/modicator.nvim",
        event = "BufWinEnter",
        config = function()
            require "custom.configs.modicator"
        end
    },
    {
        "Pocco81/auto-save.nvim",
        event = "BufReadPost",
        config = function()
            require "custom.configs.autosave"
        end
    },
    {
        "akinsho/toggleterm.nvim",
        version = "*",
        opts = {
            direction = "float",
            float_opts = {
                border = "double"
            }
        },
        init = function()
            require "custom.configs.toggleterm"
        end,
        cmd = {"ToggleTerm", "TermExec", "LazyGitToggle", "LazyDockerToggle"},
        keys = {"<leader>gg", "<leader>dd"}
    },
    {
        "MattesGroeger/vim-bookmarks",
        cmd = "BookmarkToggle"
    },
    {
        "code-biscuits/nvim-biscuits",
        event = "BufRead",
        dependencies = {"nvim-treesitter/nvim-treesitter"},
        config = function()
            require "custom.configs.biscuits"
        end
    },
    {
        "nvim-treesitter/nvim-treesitter",
        autotag = {
            enable = true,
            filetypes = {"html", "tsx", "xml"}
        },
        opts = {
            ensure_installed = {
                "html",
                "css",
                "bash",
                "typescript",
                "yaml",
                "dockerfile",
                "javascript",
                "tsx",
                "json",
                "markdown",
                "markdown_inline",
                "scss",
                "toml",
                "regex",
                "php",
                "kotlin"
            }
        }
    },
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        opts = {} -- this is equalent to setup({}) function
    },
    {
        "editorconfig/editorconfig-vim",
        lazy = false
    },
    {
        "windwp/nvim-ts-autotag",
        config = function()
            require("nvim-ts-autotag").setup {
                filetypes = {"html", "tsx", "xml"}
            }
        end
    },
    {
        "uga-rosa/translate.nvim",
        cmd = {"Translate"},
        opts = function()
            vim.g.deepl_api_auth_key = data.deeplApiKey
            return {
                default = {
                    command = "deepl_free",
                    output = "replace"
                }
            }
        end
    },
    {
        "mattn/emmet-vim",
        opt = {},
        ft = {"xml", "ts", "html", "htm", "tsx", "jsx"}
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            require "plugins.configs.lspconfig"
            require "custom.configs.lspconfig"
        end
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
                "typescript-language-server"
            }
        }
    }
}

return plugins
