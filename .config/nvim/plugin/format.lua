require('conform').setup {
  notify_on_error = true,
  default_format_opts = {
    lsp_format = 'fallback',
    stop_after_first = true,
  },
  format_on_save = function(bufnr)
    if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then return nil end
    return {
      timeout_ms = 500,
      lsp_fallback = true,
    }
  end,
  formatters_by_ft = {
    rust = { 'rustfmt' },
    javascript = { 'prettier', 'eslint_d', 'prettierd' },
    typescript = { 'prettier', 'eslint_d', 'prettierd' },
    java = { 'google-java-format' },
    css = { 'eslint_d', 'prettierd', 'prettier' },
    json = { 'jq', 'prettierd', 'prettier' },
    lua = { 'stylua' },
    markdown = { 'markdownlint' },
    python = { 'black' },
    yaml = { 'trim_whitespace' },
    terraform = { 'terraform_fmt' },
    hcl = { 'terragrunt_hclfmt', 'hcl' },
    tex = { 'tex-fmt' },
    toml = { 'taplo' },
    ['_'] = { 'trim_whitespace' },
  },
}

vim.api.nvim_create_autocmd({ 'BufRead', 'LspAttach' }, {
  group = vim.api.nvim_create_augroup('format-check', { clear = true }),
  pattern = '*',
  callback = function(e)
    if e.event == 'LspAttach' and not select(2, require('conform').list_formatters_to_run(e.buf)) then return end

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
