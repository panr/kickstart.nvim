return {
  "jose-elias-alvarez/null-ls.nvim",
  config = function()
    local status, null_ls = pcall(require, "null-ls")
    if (not status) then return end

    local formatting = null_ls.builtins.formatting
    -- local code_actions = null_ls.builtins.code_actions
    -- local diagnostics = null_ls.builtins.diagnostics

    -- Diagnostics
    vim.diagnostic.config({
      virtual_text = false,
      update_in_insert = false,
      float = {
        border = "single",
        format = function(diagnostic)
          return string.format("%s: %s [%s]",
            diagnostic.source,
            diagnostic.message,
            diagnostic.code or diagnostic.user_data.lsp.coded
          )
        end
      }
    })

    -- to setup format on save
    local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

    null_ls.setup({
      sources = {
        formatting.prettier,
        formatting.stylua,
        -- code_actions.eslint,
        -- diagnostics.eslint.with({
        --   condition = function(utils)
        --     return utils.root_has_file({
        --       ".eslintrc",
        --       ".eslintrc.json",
        --       ".eslintrc.js"
        --     })
        --   end,
        -- }),
      },
      -- configure format on save
      on_attach = function(current_client, bufnr)
        if current_client.supports_method("textDocument/formatting") then
          vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
          vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup,
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.format({
                filter = function(client)
                  if vim.bo.filetype == 'html' then
                    return false
                  end
                  --  only use null-ls for formatting instead of lsp serve r
                  return client.name == "null-ls"
                end,
                bufnr = bufnr,
              })
            end,
          })
        end
      end,
    })
  end
}
