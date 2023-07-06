-- [[ Configure LSP ]]
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)

    set_key('n', '<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame', { buffer = bufnr }, 'LSP')
    set_key('n', '<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction', { buffer = bufnr }, 'LSP')
  
    set_key('n', 'gd', vim.lsp.buf.definition, '[G]oto [D]efinition', { buffer = bufnr }, 'LSP')
    set_key('n', 'gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences', { buffer = bufnr }, 'LSP')
    set_key('n', 'gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation', { buffer = bufnr }, 'LSP')
    set_key('n', '<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition', { buffer = bufnr }, 'LSP')
    set_key('n', '<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols', { buffer = bufnr }, 'LSP')
    set_key('n', '<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols', { buffer = bufnr }, 'LSP')
  
    -- See `:help K` for why this keymap
    set_key('n', 'K', vim.lsp.buf.hover, 'Hover Documentation', { buffer = bufnr }, 'LSP')
    set_key('n', '<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation', { buffer = bufnr }, 'LSP')
  
    -- Lesser used LSP functionality
    set_key('n', 'gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration', { buffer = bufnr }, 'LSP')
    set_key('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder', { buffer = bufnr }, 'LSP')
    set_key('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder', { buffer = bufnr }, 'LSP')
    set_key('n', '<leader>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, '[W]orkspace [L]ist Folders', { buffer = bufnr }, 'LSP')
  
    -- Create a command `:Format` local to the LSP buffer
    vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
      vim.lsp.buf.format()
    end, 'Format current buffer with LSP' })
  end
  
  -- Enable the following language servers
  --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
  --
  --  Add any additional override configuration in the following tables. They will be passed to
  --  the `settings` field of the server config. You must look up that documentation yourself.
  local servers = {
    -- clangd = {},
    -- gopls = {},
    -- pyright = {},
    -- rust_analyzer = {},
    -- tsserver = {},
  
    lua_ls = {
      Lua = {
        workspace = { checkThirdParty = false },
        telemetry = { enable = false },
      },
    },
  }
  
  -- Setup neovim lua configuration
  require('neodev').setup()
  
  -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
  
  -- Ensure the servers above are installed
  local mason_lspconfig = require 'mason-lspconfig'
  
  mason_lspconfig.setup {
    ensure_installed = vim.tbl_keys(servers),
  }
  
  mason_lspconfig.setup_handlers {
    function(server_name)
      require('lspconfig')[server_name].setup {
        capabilities = capabilities,
        on_attach = on_attach,
        settings = servers[server_name],
      }
    end,
  }
  