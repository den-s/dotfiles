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

null_ls.setup({
	debug = true,
  root_dir = nls_utils.root_pattern ".git",
	sources = {
    formatting.prettierd,
    formatting.fish_indent,
    formatting.fixjson,
    formatting.isort,
    diagnostics.flake8,
    diagnostics.pylint,
    diagnostics.eslint_d,
    --[[ diagnostics.eslint_d.with({ "--cache", "-f", "json", "--stdin", "--stdin-filename", "$FILENAME" }), ]]
    diagnostics.jsonlint,
	},
})
