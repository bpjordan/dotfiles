local M = {}

function M.setup()
  vim.api.nvim_create_autocmd({ 'BufNewFile' }, {
    group = vim.api.nvim_create_augroup('notebook-skel', { clear = true }),
    pattern = { '*.ipynb' },
    callback = function(ev) vim.cmd.read(vim.fn.stdpath('config') .. '/skel/ipynb.skel') end,
  })

  vim.api.nvim_create_autocmd({ 'FileType' }, {
    pattern = 'markdown',
    callback = function() require('quarto').activate() end,
  })
end

return M
