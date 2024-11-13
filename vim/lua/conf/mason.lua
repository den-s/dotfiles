local present, mason = pcall(require, "mason")

if not present then
  return
end

local lsp_present, mason_lspconfig = pcall(require, "mason-lspconfig")

if not lsp_present then
  return
end

mason.setup({
  ensure_installed = { "lua-language-server" }, -- not an option from mason.nvim
})

-- vim.api.nvim_create_user_command("MasonInstallAll", function()
--   vim.cmd("MasonInstall " .. table.concat(options.ensure_installed, " "))
-- end, {})

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
