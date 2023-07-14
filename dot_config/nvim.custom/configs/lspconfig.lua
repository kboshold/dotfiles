local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"
local servers = { "html", "cssls", "clangd", "angularls", "tsserver", "docker_compose_language_service"}

  lspconfig['kotlin_language_server'].setup {
    on_attach = on_attach,
    capabilities = capabilities,
    filetypes = { "kotlin", "kt" }
  }

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end
