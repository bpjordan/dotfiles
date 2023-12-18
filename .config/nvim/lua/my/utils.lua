local M = {}

local git_dir_cache = {}

M.is_git = function(dir)
  local cwd = dir or vim.fn.getcwd()

  if git_dir_cache[cwd] == nil then
    vim.fn.system('git rev-parse --is-inside-work-tree')
    git_dir_cache[cwd] = vim.v.shell_error == 0
  end

  return git_dir_cache[cwd]
end

M.lualine_reg = function()
  local reg = vim.fn.reg_recording()
  return reg
end

M.lualine_lsp_attached = function()
  local clients = vim.lsp.get_active_clients { bufnr = vim.api.nvim_get_current_buf() }

  if #clients == 0 then return '' end

  local main_client = clients[1].name

  if #clients > 1 then return string.format('%s [+%d]', main_client, #clients - 1) end

  return main_client
end

return M
