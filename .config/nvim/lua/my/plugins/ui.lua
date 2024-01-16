return {
  {
    'folke/tokyonight.nvim',
    priority = 1000,
    opts = {
      style = 'moon',
      transparent = true,
      dim_inactive = true,
      on_highlights = function(hl, co)
        hl.NavicText.bg = co.bg_dark
        hl.NavicSeparator.bg = co.bg_dark
      end,
    },
  },

  { -- Set lualine as statusline
    'nvim-lualine/lualine.nvim',
    -- See `:help lualine.txt`
    dependencies = {
      'SmiteshP/nvim-navic',
    },
    event = 'UIEnter',
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
      sections = {
        lualine_a = { 'mode' },
        lualine_b = {
          'branch',
          { 'diff', source = require('my.utils').lualine_diff_source },
          'diagnostics',
          {
            require('my.utils').lualine_reg,
            icon = { '', color = { fg = 'red' } },
          },
        },
        lualine_c = { 'filename' },
        lualine_x = { 'encoding', 'fileformat', 'filetype' },
        lualine_y = { 'progress' },
        lualine_z = { 'location' },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { 'filename' },
        lualine_x = { 'location' },
        lualine_y = {},
        lualine_z = {},
      },
      winbar = {
        lualine_a = {},
        lualine_c = { { "require'nvim-navic'.get_location()" } },
        lualine_y = {
          {
            require('my.utils').lualine_lsp_attached,
            icon = '󰺯',
          },
          {
            require('my.utils').lualine_formatter_attached,
            icon = '󱩽',
            color = function()
              if vim.b.disable_autoformat or vim.g.disable_autoformat then
                return 'lualine_b_diagnostics_error_normal'
              end
            end,
          },
        },
      },
    },
  },

  {
    'folke/noice.nvim',
    event = 'UIEnter',
    opts = {
      lsp = {
        -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
        override = {
          ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
          ['vim.lsp.util.stylize_markdown'] = true,
          ['cmp.entry.get_documentation'] = true,
        },
      },
      -- routes = {
      --   {
      --     view = 'split',
      --     filter = { min_height = 20 },
      --   },
      -- },
      views = {
        mini = {
          win_options = {
            winblend = 0,
          },
        },
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
      'MunifTanjim/nui.nvim',
      'rcarriga/nvim-notify',
    },
  },
  {
    'rcarriga/nvim-notify',
    lazy = true,
    opts = {
      render = 'compact',
      stages = 'fade',
    },
  },

  {
    'nvim-telescope/telescope.nvim',
    event = 'VeryLazy',
    config = function(_, opts)
      local telescope = require('telescope')
      telescope.setup(opts)
      pcall(telescope.load_extension, 'fzf')
      pcall(telescope.load_extension, 'ui-select')
    end,
    opts = {
      defaults = {
        path_display = { 'smart' },
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
        cond = function() return vim.fn.executable('make') == 1 end,
      },
    },
  },
  {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    config = function(_, opts) require('harpoon'):setup(opts) end,
    lazy = true,
  },
}
