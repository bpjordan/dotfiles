
return {
  -- {
  --   'navarasu/onedark.nvim',
  --   priority = 1000,
  --   config = function (_, opts)
  --     require('onedark').setup(opts)
  --     require('onedark').load()
  --   end,
  --
  --   opts = {
  --     style = 'warmer',
  --     transparent = true,
  --
  --     lualine = {
  --       transparent = true
  --     },
  --   },
  --
  -- },
  --
  {
    'folke/tokyonight.nvim',
    priority = 1000,
    config = function (_, opts)
      require('tokyonight').setup(opts)
      vim.cmd.colorscheme('tokyonight')
    end,
    opts = {
      style = 'moon',
      transparent = true,
      dim_inactive = true,
    },
  },

  { -- Set lualine as statusline
    'nvim-lualine/lualine.nvim',
    -- See `:help lualine.txt`
    dependencies = {
      'SmiteshP/nvim-navic'
    },
    opts = {
      options = {
        theme = 'tokyonight',
        component_separators = '|',
        section_separators = '',
      },
      extensions = {
        'trouble',
        'fugitive',
      },
      winbar = {
        lualine_b = { {"require'nvim-navic'.get_location()"} }
      }
    },
  },

  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      lsp = {
        -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },
      views = {
        mini = {
          win_options = {
            winblend = 0
          }
        }
      },
      -- you can enable a preset for easier configuration
      presets = {
        bottom_search = true, -- use a classic bottom cmdline for search
        -- command_palette = true, -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        -- inc_rename = false, -- enables an input dialog for inc-rename.nvim
      },
    },
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    }
  },

  {
    'nvim-telescope/telescope.nvim',
    config = function (_, opts)
      local telescope = require('telescope')
      telescope.setup(opts)
      pcall(telescope.load_extension, 'fzf')
      pcall(telescope.load_extension, 'ui-select')
    end,
    opts = {
      defaults = {
        mappings = {
          i = {
            ['<C-u>'] = false,
            ['<C-d>'] = false,
          },
        },
      },
    },
    version = '*',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope-ui-select.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
    },
  },
}
