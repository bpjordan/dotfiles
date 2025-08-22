local lualine_lsp_attached = function()
  local clients = vim.lsp.get_clients { bufnr = 0 }

  if #clients == 0 then return '' end

  local main_client = clients[1].name

  if #clients > 1 then return string.format('%s [+%d]', main_client, #clients - 1) end

  return main_client
end

local lualine_formatter_attached = function()
  local formatters, lsp_fallback = require('conform').list_formatters_to_run(0)

  if lsp_fallback then return 'lsp' end
  if #formatters == 0 then return '' end

  local main_formatter = formatters[1].name

  if #formatters > 1 then return string.format('%s [+%d]', main_formatter, #formatters - 1) end

  return main_formatter
end

local lualine_reg = function() return vim.fn.reg_recording() end

local lualine_diff_source = function()
  local gitsigns = vim.b.gitsigns_status_dict
  if gitsigns then
    return {
      added = gitsigns.added,
      modified = gitsigns.modified,
      removed = gitsigns.removed,
    }
  end
end

require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'tokyonight',
    component_separators = '|',
    section_separators = '',
  },
  extensions = {
    --   'trouble',
    'fugitive',
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = {
      'branch',
      { 'diff', source = lualine_diff_source },
      'diagnostics',
      {
        lualine_reg,
        icon = { '', color = { fg = 'red' } },
      },
    },
    lualine_c = { 'filename' },
    lualine_x = { 'SleuthIndicator', 'encoding', 'fileformat', 'filetype' },
    lualine_y = { 'progress' },
    lualine_z = { 'location' },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { 'filename' },
    lualine_x = { 'location' },
    lualine_y = {},
    lualine_z = {},
  },
  winbar = {
    lualine_a = {},
    lualine_c = {},
    lualine_y = {
      {
        lualine_lsp_attached,
        icon = '󰺯',
      },
      {
        lualine_formatter_attached,
        icon = '󱩽',
        color = function()
          if vim.b.disable_autoformat or vim.g.disable_autoformat then return 'lualine_b_diagnostics_error_normal' end
        end,
      },
    },
  },
}
