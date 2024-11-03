return {
  'williamboman/mason-lspconfig.nvim',
  config = function()
    -- Enable the following language servers
    local servers = {
      awk_ls = {},
      bashls = {},
      clangd = {},
      cssls = {},
      stylelint_lsp = {},
      cmake = {},
      dockerls = {},
      dotls = {},
      eslint = {},
      gopls = {
        settings = {
          gopls = {
            completeUnimported = true,
            usePlaceholders = true,
            analyses = {
              unusedparams = true,
            },
            -- codelenses = {
            --   gc_details = false,
            --   generate = true,
            --   regenerate_cgo = true,
            --   run_govulncheck = true,
            --   test = true,
            --   tidy = true,
            --   upgrade_dependency = true,
            --   vendor = true,
            -- },
            -- experimentalPostfixCompletions = true,
            -- hints = {
            --   assignVariableTypes = true,
            --   compositeLiteralFields = true,
            --   compositeLiteralTypes = true,
            --   constantValues = true,
            --   functionTypeParameters = true,
            --   parameterNames = true,
            --   rangeVariableTypes = true,
            -- },
            gofumpt = true,
            -- semanticTokens = true,
          },
        },
      },
      html = {},
      jsonls = {},
      tsserver = {
        cmd = { 'typescript-language-server', '--stdio' },
      },
      marksman = {},
      pylsp = {},
      ruby_ls = {},
      svelte = {},
      taplo = {},
      yamlls = {},
      lemminx = {},
      lua_ls = {
        settings = {
          Lua = {
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
            diagnostics = { globals = { 'vim' } },
          },
        },
      },
    }

    -- LSP settings.
    --  This function gets run when an LSP connects to a particular buffer.
    local on_attach = function(client, bufnr)
      local nmap = function(keys, func, desc)
        if desc then
          desc = 'LSP: ' .. desc
        end

        vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
      end

      nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
      nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

      nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
      nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
      nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
      nmap('gK', vim.lsp.buf.hover, '[G]oto Documentation')
      nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
      nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
      nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

      -- See `:help K` for why this keymap
      nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
      nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

      -- Lesser used LSP functionality
      nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
      nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
      nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
      nmap('<leader>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end, '[W]orkspace [L]ist Folders')

      -- Create a command `:Format` local to the LSP buffer
      vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
        vim.lsp.buf.format()
      end, { desc = 'Format current buffer with LSP' })
      -- Autoformat file on save
      vim.cmd [[autocmd BufWritePre * lua vim.lsp.buf.format()]]

      if client.name == 'tsserver' then
        client.server_capabilities.documentFormattingProvider = false -- 0.8 and later
      end

      if client.name == 'marksman' then
        vim.opt.spell = true
      end

      if client.name == 'gopls' then
        vim.opt.tabstop = 4
        vim.opt_local.tabstop = 4
      end

      -- Skip stylelint_lsp when there is no <style> tags in javascript files
      if client.name == 'stylelint_lsp' and vim.bo.filetype == 'javascript' and (vim.fn.search '<style>.*</style>' == 0) then
        client.stop()
      end
    end

    -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

    -- Ensure the servers above are installed
    local mason_lspconfig = require 'mason-lspconfig'

    mason_lspconfig.setup {
      ensure_installed = vim.tbl_keys(servers),
    }

    mason_lspconfig.setup_handlers {
      function(server_name)
        local server_setup = {
          capabilities = capabilities,
          on_attach = on_attach,
          settings = servers[server_name],
        }

        if servers[server_name] == nil then
          servers[server_name] = {}
        end

        for k, v in pairs(servers[server_name]) do
          server_setup[k] = v
        end

        require('lspconfig')[server_name].setup(server_setup)
      end,
    }
  end,
}
