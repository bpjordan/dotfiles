return {
  settings = {
    Lua = {
      diagnostics = {
        globals = {
          'vim',
          'require',
        },
      },
      workspace = {
        checkThirdParty = false,
        library = vim.api.nvim_get_runtime_file('', true),
      },
      telemetry = { enable = false },
      hint = { enable = true, paramName = 'Literal' },
    },
  },
}
