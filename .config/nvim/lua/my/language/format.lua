local M = {}

function M.setup(formatters)
  local has_local, local_config = pcall(require, 'local.format')
  if has_local and local_config.formatters then
    formatters = vim.tbl_deep_extend('force', formatters, local_config.formatters)
  end

  require('conform').setup {
    formatters_by_ft = formatters,
    notify_on_error = true,
    format_on_save = function(bufnr)
      if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then return nil end
      return {
        timeout_ms = 500,
        lsp_fallback = true,
      }
    end,
    formatters = {
      fold = {
        command = 'fold',
        args = { '-s' },
      },
    },
  }
end

return M
