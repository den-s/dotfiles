require("conform").setup({
  format_after_save = function(bufnr)
    if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
      return
    end
    return { lsp_format = "fallback" }
  end,
  formatters_by_ft = {
    lua = { "stylua" },
    -- Conform will run multiple formatters sequentially
    python = { "isort", "black", "ruff_organize_imports" },
    -- You can customize some of the format options for the filetype (:help conform.format)
    javascript = { "prettierd" },
    html = { { "prettierd" } },
  },
  formatters = {
    ruff_organize_imports = {
      command = 'ruff',
      args = {
        'check',
        '--force-exclude',
        '--select=I001',
        '--fix',
        '--exit-zero',
        '--stdin-filename',
        '$FILENAME',
        '-',
      },
      stdin = true,
      cwd = require('conform.util').root_file {
        'pyproject.toml',
        'ruff.toml',
        '.ruff.toml',
      },
    },
  },
})
