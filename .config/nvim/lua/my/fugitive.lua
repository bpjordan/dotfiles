local fugitive_augroup = vim.api.nvim_create_augroup('bjordan_fugitive', {})

local autocmd = vim.api.nvim_create_autocmd
autocmd('BufWinEnter', {
  group = fugitive_augroup,
  pattern = '*',
  callback = function()
    if vim.bo.ft ~= 'fugitive' then return end

    local bufnr = vim.api.nvim_get_current_buf()
    local remap_opts = { buffer = bufnr, remap = false }

    vim.keymap.set('n', '<leader>p', function() vim.cmd.Git('pull') end, remap_opts)

    vim.keymap.set('n', '<leader>P', function() vim.cmd.Git('push') end)
  end,
})
