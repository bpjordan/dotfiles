
return {
  -- NOTE: First, some plugins that don't require any configuration

  -- Git related plugins
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',

  -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',

  -- Useful plugin to show you pending keybinds.
  { 'folke/which-key.nvim', opts = {} },
  { -- Adds git releated signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    config = true,
  },

  { -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help indent_blankline.txt`
    opts = {
      char = '┊',
      show_trailing_blankline_indent = false,
    },
  },

  -- "gc" to comment visual regions/lines
  { 'numToStr/Comment.nvim', opts = {} },

  -- Fuzzy Finder (files, lsp, etc)
  { 'nvim-telescope/telescope.nvim', version = '*', dependencies = { 'nvim-lua/plenary.nvim' } },

  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'make',
    cond = function()
      return vim.fn.executable 'make' == 1
    end,
  },

  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
  },

  {
    'nvim-tree/nvim-tree.lua',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
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
      }
    },
  },
  {
    'ThePrimeagen/vim-be-good',
    lazy = true,
  },
  {
    'windwp/nvim-autopairs',
    dependencies = {
      'nvim-treesitter/nvim-treesitter'
    },
    opts = {
      check_ts = true
    },
  },
  'fladson/vim-kitty',
  {
    "giusgad/pets.nvim",
    dependencies = { "MunifTanjim/nui.nvim", "giusgad/hologram.nvim" },
    opts = {
      row = 6,
      column = 15,
      default_pet = "dog",
      default_style = "black",
      random = false,
    }
  }
}
