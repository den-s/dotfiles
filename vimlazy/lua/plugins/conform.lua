vim.api.nvim_create_user_command("FormatDisable", function(args)
  if args.bang then
    -- FormatDisable! will disable formatting just for this buffer
    vim.b.disable_autoformat = true
    vim.b.disable_autoformat_signs = true
  else
    vim.g.disable_autoformat = true
    vim.g.disable_autoformat_signs = true
  end
end, {
  desc = "Disable autoformat-on-save",
  bang = true,
})

vim.api.nvim_create_user_command("FormatSignsDisable", function(args)
  if args.bang then
    -- FormatDisable! will disable formatting just for this buffer
    vim.b.disable_autoformat_signs = true
  else
    vim.g.disable_autoformat_signs = true
  end
end, {
  desc = "Disable autoformat-on-save for gitsigns",
  bang = true,
})

vim.api.nvim_create_user_command("FormatEnable", function()
  vim.b.disable_autoformat = false
  vim.g.disable_autoformat = false
  vim.b.disable_autoformat_signs = false
  vim.g.disable_autoformat_signs = false
end, {
  desc = "Re-enable autoformat-on-save",
})

vim.api.nvim_create_user_command("FormatSignsEnable", function()
  vim.b.disable_autoformat_signs = false
  vim.g.disable_autoformat_signs = false
end, {
  desc = "Re-enable autoformat-on-save for gitsigns",
})

return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  keys = {
    {
      -- Customize or remove this keymap to your liking
      "<leader>f",
      function()
        require("conform").format({ async = true })
      end,
      mode = "",
      desc = "Format buffer",
    },
    {
      -- Customize or remove this keymap to your liking
      "<leader>fd",
      ":FormatDisable<cr>",
      mode = "n",
      desc = "Format Disabled",
    },
    {
      -- Customize or remove this keymap to your liking
      "<leader>fe",
      ":FormatEnable<cr>",
      mode = "n",
      desc = "Format Enabled",
    },
    {
      -- Customize or remove this keymap to your liking
      "<leader>fsd",
      ":FormatSignsDisable<cr>",
      mode = "n",
      desc = "Format Signs Disabled",
    },
    {
      -- Customize or remove this keymap to your liking
      "<leader>fse",
      ":FormatSignsEnable<cr>",
      mode = "n",
      desc = "Format Signs Enabled",
    },
  },
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      javascript = { "deno_fmt" },
      htmldjango = { "djlint" },
      -- css = { "biome --indent-style=space --line-width=120" },
      css = { "deno_fmt" },
      html = { "deno_fmt" },
      json = { "deno_fmt" },
      -- yaml = { "denols" },
      -- graphql = { "denols" },
      python = {
        -- To fix auto-fixable lint errors.
        "ruff_fix",
        -- To run the Ruff formatter.
        "ruff_format",
        -- To organize the imports.
        "ruff_organize_imports",
      },
    },
    -- Set default options
    default_format_opts = {
      lsp_format = "fallback",
    },
    -- Set up format-on-save
    format_on_save = function(bufnr)
      local hunks = require("gitsigns").get_hunks()
      local format = require("conform").format

      if vim.g.disable_autoformat_signs or vim.b[bufnr].disable_autoformat then
        return
      else
        for i = #hunks, 1, -1 do
          local hunk = hunks[i]
          if hunk ~= nil and hunk.type ~= "delete" then
            local start = hunk.added.start
            local last = start + hunk.added.count
            -- nvim_buf_get_lines uses zero-based indexing -> subtract from last
            local last_hunk_line = vim.api.nvim_buf_get_lines(0, last - 2, last - 1, true)[1]
            local range = { start = { start, 0 }, ["end"] = { last - 1, last_hunk_line:len() } }
            format({ range = range })
          end
        end
      end
      -- Disable with a global or buffer-local variable
      if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
        return
      end
      return { timeout_ms = 500, lsp_format = "fallback" }
    end,
    -- Customize formatters
    formatters = {
      shfmt = {
        prepend_args = { "-i", "2" },
      },
      djlint = {
        args = function(self, ctx)
          local indent = vim.bo[ctx.buf].tabstop or 4
          return { "-", "--reformat", "--indent", indent }
        end,
      },
      lua = {
        args = function(self, ctx)
          local indent = vim.bo[ctx.buf].shiftwidth or 2
          return { "--indent-width", indent, "--indent_type", 'Spaces' }
        end,
      },
    },
  },
  init = function()
    vim.b.disable_autoformat = true
    vim.g.disable_autoformat = true
    vim.b.disable_autoformat_signs = true
    vim.g.disable_autoformat_signs = true
    -- If you want the formatexpr, here is the place to set it
    vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
  end,
}
