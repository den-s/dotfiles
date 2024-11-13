local onedarkpro_ok, onedarkpro = pcall(require, "onedarkpro")
if not onedarkpro_ok then
  return
end
--
--
onedarkpro.setup({
  highlights = {
    Comment = { italic = true },
    Directory = { bold = true },
    ErrorMsg = { italic = true, bold = true }
  }
  -- options = {
  --   bold = true, -- Use bold styles?
  --   italic = true, -- Use italic styles?
  --   underline = true, -- Use underline styles?
  --   undercurl = true, -- Use undercurl styles?
  --
  --   cursorline = false, -- Use cursorline highlighting?
  --   transparency = true, -- Use a transparent background?
  --   terminal_colors = true, -- Use the theme's colors for Neovim's :terminal?
  --   highlight_inactive_windows = false, -- When the window is out of focus, change the normal background?
  -- }
})

vim.cmd("colorscheme onedark")

-- vim.cmd("colorscheme onedark")
