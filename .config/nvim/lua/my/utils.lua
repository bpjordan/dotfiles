
local M = {}

local git_dir_cache = {}

M.is_git = function (dir)
  local cwd = dir or vim.fn.getcwd()

  if git_dir_cache[cwd] == nil then
    vim.fn.system("git rev-parse --is-inside-work-tree")
    git_dir_cache[cwd] = vim.v.shell_error == 0
  end

  return git_dir_cache[cwd]
end

M.lualine_reg = function()

  local reg = vim.fn.reg_recording()
  return reg
end

return M
