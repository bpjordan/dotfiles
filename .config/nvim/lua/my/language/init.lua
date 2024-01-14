require('my.language.lsp').setup {
  gopls = {},
  rust_analyzer = { install = true },
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
        format = { tabSize = 4 },
        signatureHelp = { enabled = true },
        inlayHints = { parameterNames = { enabled = 'literals' } },
      },
    },
  },
}

require('my.language.completion').setup()
