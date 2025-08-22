vim.filetype.add {
  pattern = {
    ['.*/templates/.*%.ya?ml'] = 'helm',
    ['.*Tiltfile'] = 'starlark',
  },
}

require('my.language.lsp').setup {
  servers = {
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
    -- ruby_lsp = {
    --   cmd = vim.fn.executable('mise') and { 'mise', 'x', '--', 'ruby-lsp' },
    -- init_options = {
    --   -- linters = { 'standard' },
    --   enabled_features = {
    --     'codeActions',
    --     'completion',
    --     'definition',
    --     'diagnostics',
    --     'documentSymbols',
    --     'formatting',
    --     'hover',
    --     'inlayHint',
    --     'typeHierarchy',
    --     'workspaceSymbol',
    --   },
    --   featuresConfiguration = {
    --     inlayHint = {
    --       implicitHashValue = true,
    --       implicitRescue = true,
    --     },
    --   },
    -- },
    -- },
    rubocop = {
      cmd = vim.fn.executable('mise') and { 'mise', 'x', '--', 'rubocop', '--lsp' },
      root_dir = function() vim.fs.root(0, '.rubocop.yml') end,
      single_file_support = false,
    },
    tailwindcss = {
      settings = {
        tailwindCSS = {
          includeLanguages = {
            eruby = 'erb',
          },
          experimental = {
            classRegex = { "\\bclass: %w?[\\[(]([^']*)[\\])]" },
          },
        },
      },
    },
  },
  manual_servers = {
    roslyn = {
      env = { MISE_DISABLE_TOOLS = 'dotnet' }, -- use global dotnet installation to run roslyn

      path = vim.fs.joinpath(vim.fn.stdpath('data'), 'mason', 'bin', 'roslyn'),
      condition = function() return vim.fn.executable('mise') end,
      cmd = {
        'mise',
        'x',
        'dotnet@9',
        '--',
        vim.fs.joinpath(vim.fn.stdpath('data'), 'mason', 'bin', 'roslyn'),
        '--logLevel=Information',
        '--extensionLogDirectory=' .. vim.fs.dirname(vim.lsp.get_log_path()),
        '--stdio',
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
  markdown = { 'prettierd', 'prettier', 'markdownlint' },
  python = { 'black' },
  yaml = { 'trim_whitespace' },
  terraform = { 'terraform_fmt' },
  hcl = { 'terragrunt_hclfmt', 'hcl' },
  ruby = function(bufnr) return { vim.fs.root(bufnr, '.rubocop.yml') and 'rubocop', 'rubyfmt' } end,
  eruby = { 'erb_format' },
  sql = { 'sqlfluff' },
  ['_'] = { 'trim_whitespace' },
}

require('my.language.completion').setup()
