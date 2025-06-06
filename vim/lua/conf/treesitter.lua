local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
  return
end

configs.setup ({
  ensure_installed = {
    "typescript",
    "javascript",
    "htmldjango",
    "css",
    "scss",
    "html",
    "json",
    "python",
    "lua",
    "bash",
    "fish",
    "graphql",
    "regex",
    "vim",
    "tsx",
  }, -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)
  -- ignore_install = { "" }, -- List of parsers to ignore installing
  autopairs = {
    enable = true,
  },
  highlight = {
    enable = true, -- false will disable the whole extension
  },
  indent = { enable = true, disable = { "yaml" } },
  ts_context_commentstring = {
    enable = true,
    enable_autocmd = false,
  },
})
