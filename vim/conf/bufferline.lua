local status_ok, bufferline = pcall(require, "bufferline")
if not status_ok then
  return
end

bufferline.setup {
  options = {
    -- indicator_icon = '▎',
    -- offsets = { { filetype = "NvimTree", text = "", padding = 1 } },
    buffer_close_icon = '',
    modified_icon = '●',
    close_icon = '',
    left_trunc_marker = '',
    right_trunc_marker = '',
    show_buffer_close_icons = false,
    show_close_icon = false,
    separator_style = "thin",
    always_show_bufferline = false,
    show_tab_indicators = true,
    -- numbers = numbers,
  }
}
