require('lualine').setup{
  options = {
    theme = 'auto',
    component_separators = '',
    section_separators = { left = '', right = '' },
    disabled_filetypes = {'fugitive', 'vim-plug', 'NvimTree'},
    always_divide_middle = true,
  },
}
