return {
  -- NOTE: First, some plugins that don't require any configuration

  -- Git related plugins
  {
    'tpope/vim-fugitive',
    dependencies = {
      'tpope/vim-rhubarb',
    },
    cmd = { 'Git', 'Gvdiffsplit' },
    cond = require('my.utils').is_git,
  },

  -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',

  -- Useful plugin to show you pending keybinds.
  { 'folke/which-key.nvim', opts = {} },
  { -- Adds git releated signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    config = true,
    cond = require('my.utils').is_git,
    event = 'UIEnter',
  },

  { -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help indent_blankline.txt`
    tag = 'v2.20.8',
    opts = {
      char = '┊',
      show_trailing_blankline_indent = false,
    },
  },

  -- "gc" to comment visual regions/lines
  { 'numToStr/Comment.nvim', opts = {} },

  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
  },

  {
    'nvim-tree/nvim-tree.lua',
    cmd = 'NvimTree',
    init = function()
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1
    end,
    opts = {
      sort_by = 'case_sensitive',
      renderer = {
        group_empty = true,
      },
      filters = {
        dotfiles = false,
      },
      diagnostics = {
        enable = true,
        show_on_dirs = true,
      },
      actions = {
        change_dir = { enable = false },
        expand_all = { exclude = { '.git', 'target', 'build', 'node_modules' } },
        open_file = { quit_on_open = true },
      },
    },
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
  },
  {
    'ThePrimeagen/vim-be-good',
    cmd = 'VimBeGood',
  },
  {
    'windwp/nvim-autopairs',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
    },
    opts = {
      check_ts = true,
    },
    event = 'InsertEnter',
  },
  {
    'giusgad/pets.nvim',
    dependencies = { 'MunifTanjim/nui.nvim', 'giusgad/hologram.nvim' },
    cmd = { 'PetsNew', 'PetsNewCustom' },
    opts = {
      row = 6,
      column = 15,
      default_pet = 'dog',
      default_style = 'black',
      random = false,
    },
  },
  {
    'kristijanhusak/vim-dadbod-ui',
    cmd = 'DBUI',
    dependencies = {
      'kristijanhusak/vim-dadbod-completion',
      'tpope/vim-dadbod',
    },
  },
}
