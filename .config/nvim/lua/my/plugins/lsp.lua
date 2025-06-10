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
  'stevearc/conform.nvim',
  'nanotee/sqls.nvim',
}
