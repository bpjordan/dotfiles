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
  local clients = vim.lsp.get_clients { bufnr = 0 }

  if #clients == 0 then return '' end

  local main_client = clients[1].name

  if #clients > 1 then return string.format('%s [+%d]', main_client, #clients - 1) end

  return main_client
end

M.lualine_formatter_attached = function()
  local formatters, lsp_fallback = require('conform').list_formatters_to_run(0)

  if lsp_fallback then return 'lsp' end
  if #formatters == 0 then return '' end

  local main_formatter = formatters[1].name

  if #formatters > 1 then return string.format('%s [+%d]', main_formatter, #formatters - 1) end

  return main_formatter
end

M.lualine_diff_source = function()
  local gitsigns = vim.b.gitsigns_status_dict
  if gitsigns then
    return {
      added = gitsigns.added,
      modified = gitsigns.modified,
      removed = gitsigns.removed,
    }
  end
end

return M
