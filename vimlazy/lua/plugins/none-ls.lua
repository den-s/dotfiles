return {
  'nvimtools/none-ls.nvim',
  enabled = false,

  opts = function(_, opts)
    local nls = require('null-ls')
    opts.sources = {
      -- other sources
      -- nls.formatting.ruff,
      nls.builtins.formatting.fish_indent,
      nls.builtins.diagnostics.fish,
      nls.builtins.formatting.stylua,
      nls.builtins.diagnostics.mypy.with({ extra_args = { "--ignore-missing-imports", "--ignore-missing-imports", "--follow-imports=normal" } }),
      nls.builtins.code_actions.refactoring,
    }
    return opts
  end,
}
