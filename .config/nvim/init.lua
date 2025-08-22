vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.pack.add {
  'https://github.com/tpope/vim-rhubarb',
  'https://github.com/tpope/vim-fugitive',
  'https://github.com/tpope/vim-sleuth',
  'https://github.com/folke/which-key.nvim',
  'https://github.com/folke/tokyonight.nvim',
  'https://github.com/echasnovski/mini.nvim',
  'https://github.com/lewis6991/gitsigns.nvim',
  'https://github.com/lukas-reineke/indent-blankline.nvim',
  'https://github.com/neovim/nvim-lspconfig',
  'https://github.com/nvim-treesitter/nvim-treesitter',
  'https://github.com/nvim-treesitter/nvim-treesitter-textobjects',
  'https://github.com/stevearc/oil.nvim',
  'https://github.com/windwp/nvim-autopairs',
  'https://github.com/tpope/vim-dadbod',
  'https://github.com/kristijanhusak/vim-dadbod-ui',
  'https://github.com/kristijanhusak/vim-dadbod-completion',
  'https://github.com/stevearc/conform.nvim',
  'https://github.com/nvim-lualine/lualine.nvim',
  'https://github.com/nvim-lua/plenary.nvim',
  'https://github.com/nvim-telescope/telescope.nvim',
  'https://github.com/nvim-telescope/telescope-ui-select.nvim',
  'https://github.com/nvim-telescope/telescope-fzf-native.nvim',
}

vim.lsp.enable {
  'bashls',
  'black',
  'clangd',
  'dockerls',
  'gopls',
  'jsonls',
  'lua_ls',
  'pyright',
  'rust_analyzer',
  'ts_ls',
  'yamlls',
}
