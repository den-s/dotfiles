local status_ok, catppuccin = pcall(require, "catppuccin")
if not status_ok then
	return
end

catppuccin.setup({
    transparent_background = false,
    integrations = {
      nvimtree = {
        show_root = true,
        transparent_panel = true,
      },
      indent_blankline = {
        enabled = true,
        color_indent_levels = true,
      },
    }
})

vim.g.catppuccin_flavour = "frappe" -- latte, frappe, macchiato, mocha
catppuccin.load()
