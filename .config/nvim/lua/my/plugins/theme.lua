
return { -- Theme inspired by Atom
    'navarasu/onedark.nvim',
    priority = 1000,
    config = function()

      require('onedark').setup {
        style = 'darker',
        transparent = true,

        lualine = {
          transparent = true
        }
      }

      vim.cmd.colorscheme 'onedark'
    end,
  }
