local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
  return
end

require("handlers").setup()

local servers = { "tsserver" }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  }
end
