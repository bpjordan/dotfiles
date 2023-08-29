
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
    },
  },
}
