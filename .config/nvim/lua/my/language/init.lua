vim.filetype.add {
  pattern = {
    ['.*/templates/.*%.ya?ml'] = 'helm',
  },
}

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

require('my.language.format').setup {
  rust = { 'rustfmt' },
  javascript = { 'prettier', 'eslint_d', 'prettierd' },
  typescript = { 'prettier', 'eslint_d', 'prettierd' },
  java = { 'google-java-format' },
  css = { 'eslint_d', 'prettierd', 'prettier' },
  json = { 'jq', 'prettierd', 'prettier' },
  lua = { 'stylua' },
  markdown = { 'markdownlint' },
  python = { 'black' },
  yaml = { 'trim_whitespace' },
  terraform = { 'terraform_fmt' },
  hcl = { 'terragrunt_hclfmt', 'hcl' },
  ['_'] = { 'trim_whitespace' },
}

require('my.language.completion').setup()
