local langs = {
  java = { require('efmls-configs.formatters.google_java_format') },
  javascript = { require('efmls-configs.linters.eslint_d'), require('efmls-configs.formatters.eslint_d') },
  json = { require('efmls-configs.linters.jq'), require('efmls-configs.formatters.jq') },
  lua = { require('efmls-configs.formatters.stylua') },
  rust = {
    require('efmls-configs.formatters.rustfmt'),
    { formatCommand = 'leptosfmt --stdin', formatStdin = true },
  },
  sql = {
    { formatCommand = 'sqlfmt -', formatStdin = true },
    {
      prefix = 'sqlfluff',
      lintCommand =
      'sqlfluff lint --format github-annotation-native --annotation-level warning --nocolor --disable-progress-bar ${INPUT}',
      lintIgnoreExitCode = true,
      lintStdin = false,
      lintFormats = {
        '::%totice title=SQLFluff,file=%f,line=%l,col=%c,endLine=%e,endColumn=%k::%m',
        '::%tarning title=SQLFluff,file=%f,line=%l,col=%c,endLine=%e,endColumn=%k::%m',
        '::%trror title=SQLFluff,file=%f,line=%l,col=%c,endLine=%e,endColumn=%k::%m',
      },
    },
  },
  eruby = {
    { formatCommand = 'htmlbeautifier', formatStdin = true },
  },
}

---@type vim.lsp.Config
return {
  filetypes = vim.tbl_keys(langs),
  root_markers = { '.git' },
  settings = {
    root_markers = { '.git/' },
    languages = langs,
  },
  init_options = {
    documentFormatting = true,
    documentRangeFormatting = true,
  },
}
