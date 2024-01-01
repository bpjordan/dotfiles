require('my.lsp.lsp').setup {
  gopls = {},
  rust_analyzer = { install = true },
  tsserver = { javascript = { inlayHints = { variableTypes = { enabled = true } } } },
  lua_ls = {
    install = true,
    settings = {
      Lua = {
        workspace = { checkThirdParty = false },
        telemetry = { enable = false },
        hint = { enable = true, paramName = 'Literal' },
      },
    },
  },
  jdtls = {
    settings = {
      java = {
        format = { enabled = false },
        signatureHelp = { enabled = true },
      },
    },
  },
}

require('my.lsp.completion').setup()
