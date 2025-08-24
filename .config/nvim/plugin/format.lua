require('lsp-format').setup {}

vim.lsp.config('*', {
  on_attach = require('lsp-format').on_attach,
})
