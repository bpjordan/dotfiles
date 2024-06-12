-- [[ Basic Keymaps ]]

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

vim.keymap.set('n', 'Q', '<Nop>')

vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', 'G', 'Gzz')

vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { silent = true })
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = vim.highlight.on_yank,
  group = vim.api.nvim_create_augroup('highlight_yank', {}),
  pattern = '*',
})

-- See `:help telescope.builtin`
vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader>b', require('telescope.builtin').buffers, { desc = 'Find existing [B]uffers' })
vim.keymap.set('n', '<leader>/', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer' })

vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', require('telescope.builtin').git_files, { desc = '[S]earch in [G]it repo' })
vim.keymap.set('n', '<leader>sG', require('telescope.builtin').live_grep, { desc = '[S]earch with [G]rep' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })

-- stylua: ignore start
vim.keymap.set('n', '<leader>ha', function () require('harpoon'):list():append() end, {desc = '[H]arpoon: [A]dd to list'})
vim.keymap.set('n', '<leader>hd', function () require('harpoon'):list():remove() end, {desc = '[H]arpoon: [D]elete from list'})
vim.keymap.set('n', '<leader>1', function () require('harpoon'):list():select(1) end, {desc = 'Harpoon: Select [1]'})
vim.keymap.set('n', '<leader>2', function () require('harpoon'):list():select(2) end, {desc = 'Harpoon: Select [2]'})
vim.keymap.set('n', '<leader>3', function () require('harpoon'):list():select(3) end, {desc = 'Harpoon: Select [3]'})
vim.keymap.set('n', '<leader>4', function () require('harpoon'):list():select(4) end, {desc = 'Harpoon: Select [4]'})
-- stylua: ignore end
vim.keymap.set(
  'n',
  '<leader><space>',
  function() require('harpoon').ui:toggle_quick_menu(require('harpoon'):list()) end,
  { desc = 'Harpoon: Open UI' }
)

-- file tree
vim.keymap.set(
  'n',
  '<leader>ft',
  function() require('nvim-tree.api').tree.open { find_file = true } end,
  { desc = 'Open [F]ile [T]ree' }
)

-- [[ Configure Treesitter ]]
-- See `:help nvim-treesitter`
---@diagnostic disable-next-line: missing-fields
require('nvim-treesitter.configs').setup {
  -- Add languages to be installed here that you want installed for treesitter
  ensure_installed = { 'c', 'cpp', 'go', 'lua', 'python', 'rust', 'tsx', 'typescript', 'vimdoc', 'vim' },

  -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
  auto_install = true,

  highlight = { enable = true },
  indent = { enable = true, disable = { 'python' } },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '<c-space>',
      node_incremental = '<c-space>',
      scope_incremental = '<c-s>',
      node_decremental = '<M-space>',
    },
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ['aa'] = '@parameter.outer',
        ['ia'] = '@parameter.inner',
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        [']m'] = '@function.outer',
        [']]'] = '@class.outer',
      },
      goto_next_end = {
        [']M'] = '@function.outer',
        [']['] = '@class.outer',
      },
      goto_previous_start = {
        ['[m'] = '@function.outer',
        ['[['] = '@class.outer',
      },
      goto_previous_end = {
        ['[M'] = '@function.outer',
        ['[]'] = '@class.outer',
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ['<leader>a'] = '@parameter.inner',
      },
      swap_previous = {
        ['<leader>A'] = '@parameter.inner',
      },
    },
  },
}

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set(
  'n',
  '<leader>q',
  function() require('trouble').open('diagnostics') end,
  { desc = 'Open diagnostics list' }
)

-- Git keymaps
vim.keymap.set('n', '<leader>gs', vim.cmd.Git, { desc = '[G]it [S]tatus' })
vim.api.nvim_create_autocmd('BufWinEnter', {
  group = vim.api.nvim_create_augroup('window_keymaps', { clear = true }),
  pattern = '*',
  callback = function()
    if vim.bo.ft ~= 'fugitive' then return end

    vim.keymap.set(
      'n',
      '<leader>p',
      function() vim.cmd.Git { args = 'pull', bang = true } end,
      { buffer = true, desc = 'Git [P]ull' }
    )

    vim.keymap.set(
      'n',
      '<leader>P',
      function() vim.cmd.Git { args = 'push', bang = true } end,
      { buffer = true, desc = 'Git [P]ush' }
    )
  end,
})

-- Autoformatting commands
vim.api.nvim_create_user_command('Format', function(args)
  local range = nil
  if args.count ~= -1 then
    local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
    range = {
      start = { args.line1, 0 },
      ['end'] = { args.line2, end_line:len() },
    }
  end
  require('conform').format({ async = true, lsp_fallback = true, range = range }, function(err, did_edit)
    if err then
      vim.notify('Format failed: ' .. err)
    elseif not range then
      vim.b.disable_autoformat = false
    end
  end)
end, { desc = 'Run formatter', range = '%' })

vim.api.nvim_create_user_command('FormatDisable', function(args)
  if args.bang then
    vim.b.disable_autoformat = true
  else
    vim.g.disable_autoformat = true
  end
end, {
  desc = 'Disable autoformatting on save',
  bang = true,
})

vim.api.nvim_create_user_command('FormatEnable', function(args)
  vim.b.disable_autoformat = false
  if not args.bang then vim.g.disable_autoformat = false end
end, { desc = 'Re-enable autoformatting on save', bang = true })

vim.api.nvim_create_user_command('Share', function()
  ---@diagnostic disable-next-line: missing-fields
  require('tokyonight.config').extend { transparent = false }
  vim.cmd.colorscheme('tokyonight')
  vim.opt.relativenumber = false
end, { desc = 'Adjust UI for easier screen sharing' })

vim.api.nvim_create_user_command('Unshare', function()
  ---@diagnostic disable-next-line: missing-fields
  require('tokyonight.config').extend { transparent = true }
  vim.cmd.colorscheme('tokyonight')
  vim.opt.relativenumber = true
end, { desc = 'Revert UI adjustments from Share' })

vim.api.nvim_create_user_command(
  'HarpoonClear',
  function() require('harpoon'):list():clear() end,
  { desc = 'Clear Harpoon main list' }
)

vim.api.nvim_create_autocmd({ 'BufRead', 'LspAttach' }, {
  group = vim.api.nvim_create_augroup('format-check', { clear = true }),
  pattern = '*',
  callback = function(e)
    if e.event == 'LspAttach' and not require('conform').will_fallback_lsp { bufnr = e.buf } then return end

    -- Defer since checking immediately upon BufReadPost can sometimes cause concurrent modification errors
    vim.schedule(function()
      require('conform').format(
        { bufnr = e.buf, dry_run = true, async = true, quiet = true, lsp_fallback = true },
        function(err, changed)
          if err then
            vim.notify('Error checking formatters: ' .. tostring(err), vim.log.levels.WARN)
          else
            vim.b[e.buf].disable_autoformat = changed
          end
        end
      )
    end)
  end,
})
