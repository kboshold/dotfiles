local data = require("custom.data")

local plugins = {
    {
        "melkster/modicator.nvim",
        event = "BufWinEnter",
        opts = {}
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
