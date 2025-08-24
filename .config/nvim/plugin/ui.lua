require('tokyonight').setup {
  style = 'moon',
  transparent = true,
  dim_inactive = true,
  on_highlights = function(hl, co)
    hl.NavicText.bg = co.bg_dark
    hl.NavicSeparator.bg = co.bg_dark
  end,
}

vim.cmd.colorscheme('tokyonight')

require('mini.icons').setup {}
-- require('mini.cursorword').setup {}
require('mini.diff').setup {
  view = {
    style = 'sign',
    signs = { add = '▎', change = '▎', delete = '_' },
  },
}

require('which-key').setup {}
require('ibl').setup {
  indent = {
    char = '┊',
  },
}

require('oil').setup {
  view_options = {
    show_hidden = true,
    is_always_hidden = function(name) return name == '.git/' or vim.endswith(name, '.un~') end,
  },
}

local telescope = require('telescope')

telescope.setup {
  defaults = {
    path_display = { 'smart' },
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
      },
    },
  },
}

pcall(telescope.load_extension, 'fzf')
pcall(telescope.load_extension, 'ui-select')
