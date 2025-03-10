return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function () 
      local configs = require("nvim-treesitter.configs")

      configs.setup({
      ensure_installed = {"typescript", "htmldjango", "javascript", "css", "scss", "html", "json", "python", "lua", "bash", "fish", "graphql", "regex", "vim", "tsx"},
          sync_install = false,
          highlight = { enable = true },
          indent = { enable = true },
          autopairs = { enable = true },
          ts_context_commentstring = {
            enable = true,
            enable_autocmd = false,
          },
        })
    end

    -- opts = {
    --   -- add tsx and treesitter
    --   ensure_installed = {
    --     "typescript",
    --     "htmldjango",
    --     "javascript",
    --     "css",
    --     "scss",
    --     "html",
    --     "json",
    --     "python",
    --     "lua",
    --     "bash",
    --     "fish",
    --     "graphql",
    --     "regex",
    --     "vim",
    --     "tsx",
    --     "help",
    --   },
    --   sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)
    --   -- ignore_install = { "" }, -- List of parsers to ignore installing
    --   autopairs = {
    --     enable = true,
    --   },
    --   highlight = {
    --     enable = true, -- false will disable the whole extension
    --     disable = {},
    --   },
    --   indent = { enable = true, disable = { "yaml" } },
    --   ts_context_commentstring = {
    --     enable = true,
    --     enable_autocmd = false,
    --   },
  -- },
}
