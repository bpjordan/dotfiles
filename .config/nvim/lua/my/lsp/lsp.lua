local M = {}

function M.setup(servers)
  local has_local, local_config = pcall(require, 'local.lsp')
  if has_local and local_config.servers then servers = vim.tbl_deep_extend('force', servers, local_config.servers) end

  -- LSP settings.
  --  This function gets run when an LSP connects to a particular buffer.
  local on_attach = function(client, bufnr)
    -- NOTE: Remember that lua is a real programming language, and as such it is possible
    -- to define small helper and utility functions so you don't have to repeat yourself
    -- many times.
    --
    -- In this case, we create a function that lets us more easily define mappings specific
    -- for LSP related items. It sets the mode, buffer and description for us each time.
    local nmap = function(keys, func, desc)
      if desc then desc = 'LSP: ' .. desc end

      vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
    end

    nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
    nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

    nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
    nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
    nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
    nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
    nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
    nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

    -- See `:help K` for why this keymap
    nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
    nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

    -- Lesser used LSP functionality
    nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

    if vim.lsp.inlay_hint and client.server_capabilities.inlayHintProvider then
      vim.lsp.inlay_hint.enable(bufnr, true)
      nmap(
        '<leader>it',
        function() vim.lsp.inlay_hint.enable(bufnr, not vim.lsp.inlay_hint.is_enabled(bufnr)) end,
        '[I]nlay Hint [T]oggle'
      )
    end
  end

  -- Setup neovim lua configuration
  require('neodev').setup()

  -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

  local ensure_installed = nil
  if vim.iter then
    ensure_installed = vim.iter.filter(
      function(server_name) return servers[server_name].install end,
      vim.tbl_keys(servers)
    )
  end

  -- Setup mason so it can manage external tooling
  require('mason').setup { ensure_installed = ensure_installed }

  -- Ensure the servers above are installed
  local mason_lspconfig = require('mason-lspconfig')

  mason_lspconfig.setup()

  mason_lspconfig.setup_handlers {
    function(server_name)
      local config = servers[server_name]
      require('lspconfig')[server_name].setup {
        cmd = config and config.cmd,
        settings = config and config.settings,
        cmd_env = config and config.env,
        capabilities = capabilities,
        on_attach = function(ev, bufnr)
          on_attach(ev, bufnr)
          if config and config.on_attach then config.on_attach(ev, bufnr) end
        end,
      }
    end,
  }
end

return M
