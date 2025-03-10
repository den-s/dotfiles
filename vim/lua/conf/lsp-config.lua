-- local lspconfig_ok, lsp = pcall(require, "lsp-zero")
-- if not lspconfig_ok then
--   return
-- end

-- lsp.preset('recommended')
--
-- lsp.set_preferences({
--   suggest_lsp_servers = true,
--   setup_servers_on_start = true,
--   set_lsp_keymaps = false,
--   configure_diagnostics = true,
--   cmp_capabilities = false,
--   manage_nvim_cmp = false,
--   call_servers = 'local',
--   sign_icons = {
--     error = '✘',
--     warn = '',
--     hint = '⚑',
--     info = ''
--   },
-- })

-- local handler = vim.lsp.with(
--     vim.lsp.handlers.location, {
--       location_callback = function(location)
--         vim.cmd [[vsplit]]
--         vim.lsp.util.jump_to_location(location)
--       end
--     }
--
--   local params = vim.lsp.util.make_position_params()
--   vim.lsp.buf_request(0, 'textDocument/definition', params, handler)

--[[ local function goto_definition(split_cmd)
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
end ]]

--[[ lsp.on_attach(function (client, bufnr)
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
) ]]

-- lsp.setup()
