require("mason").setup()

vim.opt.signcolumn = 'yes'

local lspconfig_defaults = require('lspconfig').util.default_config
lspconfig_defaults.capabilities = vim.tbl_deep_extend(
  'force',
  lspconfig_defaults.capabilities,
  require('cmp_nvim_lsp').default_capabilities()
)

local function goto_definition(split_cmd)
  local util = vim.lsp.util
  local log = require("vim.lsp.log")

  local handler = function(_, result, ctx)
    if result == nil or vim.tbl_isempty(result) then
      local _ = log.info() and log.info(ctx.method, "No location found")
      return nil
    end

    if split_cmd then
      vim.cmd(split_cmd)
    end

    if vim.tbl_islist(result) then
      util.jump_to_location(result[1])
    else
      util.jump_to_location(result)
    end
  end

  return handler
end

local function open_definition_vsplit ()
  local handler = goto_definition('vsplit')
  local params = vim.lsp.util.make_position_params()
  vim.lsp.buf_request(0, 'textDocument/definition', params, handler)
end

local function open_definition_newtab ()
  local handler = goto_definition('tab split')
  local params = vim.lsp.util.make_position_params()
  vim.lsp.buf_request(0, 'textDocument/definition', params, handler)
end

local on_attach = function (client, bufnr)
  local opts = { buffer = bufnr, remap = false }
  vim.keymap.set('n', 'gd', function () vim.lsp.buf.definition() end, opts)
  vim.keymap.set('n', 'gdv', function () open_definition_vsplit() end, opts)
  vim.keymap.set('n', 'gdt', function() open_definition_newtab() end, opts)
  vim.keymap.set('n', 'gr', function() vim.lsp.buf.references() end, opts)
  vim.keymap.set('n', 'K', function() vim.lsp.buf.hover() end, opts)
  vim.keymap.set('n', 'gi', function() vim.lsp.buf.implementation() end, opts)
  vim.keymap.set('n', '<C-k>', function() vim.lsp.buf.signature_help() end, opts)
  vim.keymap.set('n', '<leader>rn', function() vim.lsp.buf.rename() end, opts)
  vim.keymap.set('n', '<leader>ca', function() vim.lsp.buf.code_action() end, opts)
  vim.keymap.set('n', '<leader>e', function() vim.diagnostic.open_float() end, opts)
  vim.keymap.set('n', '[d', function() vim.diagnostic.goto_prev() end, opts)
  vim.keymap.set('n', ']d', function() vim.diagnostic.goto_next() end, opts)
  vim.keymap.set('n', '<leader>af', function() vim.lsp.buf.formatting() end, opts)
end

-- local capabilities = vim.tbl_deep_extend(
--   "force",
--   vim.lsp.protocol.make_client_capabilities(),
--   require("cmp_nvim_lsp").default_capabilities()
-- )
-- capabilities.textDocument.foldingRange = {
--   dynamicRegistration = false,
--   lineFoldingOnly = true,
-- }

require("mason-lspconfig").setup({
  ensure_installed = { "basedpyright" }, -- not an option from mason.nvim
  automatic_installation = true,
  handlers = {
    function(server_name)
      require('lspconfig')[server_name].setup({
        on_attach = on_attach,
        -- capabilities = capabilities,
      })
    end,
    basedpyright = function()
      require('lspconfig').basedpyright.setup({
        on_attach = on_attach,
        -- capabilities = capabilities,
        settings = {
          basedpyright = {
            disableOrganizeImports = true,
            disableTaggedHints = false,
            analysis = {
              typeCheckingMode = "standard",
              useLibraryCodeForTypes = true, -- Analyze library code for type information
              autoImportCompletions = true,
              autoSearchPaths = true,
              diagnosticSeverityOverrides = {
                reportIgnoreCommentWithoutRule = true,
              },
            },
          },
          python = {
            analysis = {
              ignore = { '*' }, -- Using Ruff
              typeCheckingMode = 'off', -- Using mypy
            },
          },
        }

        -- capabilities = (function()
        --     local capabilities = vim.lsp.protocol.make_client_capabilities()
        --     capabilities.textDocument.publishDiagnostics.tagSupport.valueSet = { 2 }
        --     return capabilities
        --   end)(),
    --   })
    -- end,
    -- ruff = function()
    --   require('lspconfig').ruff.setup({
    --     on_attach = function(client, bufnr)
    --       client.server_capabilities.hoverProvider = false
    --       on_attach(client, bufnr)
    --     end,
    --   })
    -- end,
    -- eslint = function()
    --   require('lspconfig').eslint.setup({
    --     settings = {
    --         autoFixOnSave = true
    --     }
      })
    end,
  },
})

-- require('lspconfig').basedpyright.setup({
--   on_attach = on_attach,
--   capabilities = capabilities,
--   settings = {
--     basedpyright = {
--       disableOrganizeImports = true,
--       disableTaggedHints = false,
--       analysis = {
--         -- ignore = { '*' }, -- Using Ruff
--         -- typeCheckingMode = 'off', -- Using mypy
--         typeCheckingMode = "standard",
--         useLibraryCodeForTypes = true, -- Analyze library code for type information
--         autoImportCompletions = true,
--         autoSearchPaths = true,
--         diagnosticSeverityOverrides = {
--           reportIgnoreCommentWithoutRule = true,
--         },
--       },
--     },
--     python = {
--       analysis = {
--         ignore = { '*' }, -- Using Ruff
--         typeCheckingMode = 'off', -- Using mypy
--       },
--     },
--   }
-- })



-- vim.api.nvim_create_user_command("MasonInstallAll", function()
--   vim.cmd("MasonInstall " .. table.concat(options.ensure_installed, " "))
-- end, {})
--
-- require('lspconfig').basedpyright.setup{
--   settings = {
--     basedpyright = {
--
--       disableLanguageServices = true,
--       analysis = {
--         typeCheckingMode = "standard",
--       }
--     }
--   }
-- }

-- require'lspconfig'.pylsp.setup{
--   settings = {
--     pylsp = {
--       plugins = {
--         pycodestyle = {
--           ignore = {'W391'},
--           maxLineLength = 100
--         },
--         rope_autoimport = {
--           enabled = true
--         },
--         rope_completion = {
--           enabled = true
--         },
--         pyflakes = {
--           enabled = false
--         }
--       }
--     }
--   }
-- }
--
