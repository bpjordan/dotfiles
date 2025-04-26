---@type LazySpec
return {
  {
    'benlubas/molten-nvim',
    version = '^1.0.0', -- use version <2.0.0 to avoid breaking changes
    build = ':UpdateRemotePlugins',
    ft = { 'quarto', 'markdown' },
    dependencies = {
      'quarto-dev/quarto-nvim',
      'GCBallesteros/jupytext.nvim',
    },
    init = function()
      -- these are examples, not defaults. Please see the readme
      vim.g.python3_host_prog = vim.fn.expand('~/.local/state/venvs/nvim/bin/python3')
      vim.g.molten_image_provider = 'none'
      vim.g.molten_virt_text_output = true
      vim.g.molten_output_win_max_height = 20
      vim.g.molten_auto_open_output = false
      vim.g.molten_virt_lines_off_by_1 = true
      vim.g.molten_auto_init_behavior = 'raise'
      vim.g.molten_output_show_more = true
      vim.g.molten_enter_output_behavior = 'open_and_enter'
    end,
  },
  {
    'quarto-dev/quarto-nvim',
    dependencies = {
      'jmbuhr/otter.nvim',
      'nvim-treesitter/nvim-treesitter',
    },
    opts = {
      lspFeatures = {
        languages = { 'r', 'python', 'rust' },
        chunks = 'all',
        diagnostics = {
          enabled = true,
          triggers = { 'BufWritePost', 'InsertLeave' },
        },
        completion = {
          enabled = true,
        },
      },
      keymap = {
        -- NOTE: setup your own keymaps:
        hover = 'K',
        definition = '<leader>gd',
        rename = '<leader>rn',
        references = '<leader>gr',
        format = '<leader>gf',
      },
      codeRunner = {
        enabled = true,
        default_method = 'molten',
      },
    },
  },
  {
    'GCBallesteros/jupytext.nvim',
    opts = {
      style = 'markdown',
      output_extension = 'md',
      force_ft = 'markdown',
    },
  },
  {
    'jbyuki/nabla.nvim',
    keys = {
      { 'L', function() require('nabla').popup() end, desc = 'View [L]aTeX Equation' },
    },
  },
}
