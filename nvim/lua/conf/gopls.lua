-- Attach cmp to lspconfig
local capabilities = require('cmp_nvim_lsp').update_capabilities(
  vim.lsp.protocol.make_client_capabilities()
)
require('lspconfig').gopls.setup {
    cmd = {"gopls", "serve"},
    capabilities = capabilities,
    on_attach = on_attach,
}
