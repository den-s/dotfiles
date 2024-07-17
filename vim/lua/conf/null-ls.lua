local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
	return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics

local code_actions = null_ls.builtins.code_actions

local nls_utils = require "null-ls.utils"

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local callback = function()
  vim.lsp.buf.format({
    bufnr = bufnr,
    filter = function(client)
      return client.name == "null-ls"
    end
  })
end

null_ls.setup({
	debug = true,
  root_dir = nls_utils.root_pattern ".git",
	sources = {
    formatting.prettierd,
    formatting.fish_indent,
    formatting.fixjson,
    formatting.black,
    -- formatting.isort,
    -- diagnostics.flake8,
    -- diagnostics.pylint,
    diagnostics.eslint_d,
    --[[ diagnostics.eslint_d.with({ "--cache", "-f", "json", "--stdin", "--stdin-filename", "$FILENAME" }), ]]
    diagnostics.jsonlint,
	},
  on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = callback,
      })
    end
  end,
})
