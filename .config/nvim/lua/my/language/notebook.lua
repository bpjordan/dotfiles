local M = {}

local function auto_init_molten(e)
  vim.schedule(function()
    if require('molten.status').kernels() ~= '' then return end
    local kernels = vim.fn.MoltenAvailableKernels()

    local kernel_name = nil
    local venv = os.getenv('VIRTUAL_ENV')
    if venv ~= nil then kernel_name = string.match(venv, '/.+/(.+)') end

    if not vim.tbl_contains(kernels, kernel_name) then
      _, kernel_name = pcall(function()
        local meta = vim.json.decode(io.open(e.file, 'r'):read('a'))['metadata']
        return meta.kernelspec.name
      end)
    end

    if kernel_name ~= nil and vim.tbl_contains(kernels, kernel_name) then
      vim.cmd.MoltenInit(kernel_name)
      vim.cmd.MoltenImportOutput()
    end
  end)
end

function M.setup()
  vim.api.nvim_create_autocmd({ 'FileType' }, {
    pattern = 'markdown',
    callback = function() require('quarto').activate() end,
  })

  vim.api.nvim_create_autocmd({ 'BufAdd' }, {
    pattern = '*.ipynb',
    callback = auto_init_molten,
  })

  vim.api.nvim_create_autocmd({ 'BufEnter' }, {
    pattern = '*.ipynb',
    callback = function(e)
      if vim.v.vim_did_enter then auto_init_molten(e) end
    end,
  })

  vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
    pattern = '*.ipynb',
    callback = function()
      if require('molten.status').initialized() == 'Molten' then vim.cmd.MoltenExportOutput { bang = true } end
    end,
  })
end

return M
