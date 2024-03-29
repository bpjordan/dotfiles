return { -- LSP Configuration & Plugins
  {
    'williamboman/mason-lspconfig',
    dependencies = {
      'neovim/nvim-lspconfig',
      { 'williamboman/mason.nvim', config = true },
      { 'folke/neodev.nvim', config = true },
    },
  },

  { -- Autocompletion
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
      'davidsierradz/cmp-conventionalcommits',
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
    },
  },
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    config = true,
  },
  {
    'folke/trouble.nvim',
    cmd = 'Trouble',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
  },
  {
    'SmiteshP/nvim-navic',
    lazy = true,
    opts = {
      lsp = {
        auto_attach = true,
      },
      highlight = true,
      click = true,
    },
  },
  {
    'stevearc/conform.nvim',
    opts = {
      formatters_by_ft = {
        rust = { 'rustfmt' },
        javascript = { { 'eslint_d', 'prettierd', 'prettier' } },
        css = { { 'eslint_d', 'prettierd', 'prettier' } },
        json = { { 'jq', 'prettierd', 'prettier' } },
        lua = { 'stylua' },
        markdown = { 'fold', 'markdownlint' },
        ['_'] = { 'trim_whitespace' },
      },
      notify_on_error = true,
      format_on_save = function(bufnr)
        if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then return end
        return {
          timeout_ms = 500,
          lsp_fallback = true,
        }
      end,
      formatters = {
        fold = {
          command = 'fold',
          args = { '-s' },
        },
      },
    },
    event = 'BufWritePre',
  },
}
