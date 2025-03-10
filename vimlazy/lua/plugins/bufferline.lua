return {
  "akinsho/bufferline.nvim",
  dependencies = "nvim-tree/nvim-web-devicons",
  enabled = false,

  -- event = "InsertEnter",
  opts = {
    options = {
      buffer_close_icon = "",
      modified_icon = "●",
      close_icon = "",
      show_buffer_close_icons = false,
      show_close_icon = false,
      separator_style = { "", "" },
      always_show_bufferline = false,
      show_tab_indicators = true,
      truncate_names = false, -- whether or not tab names should be truncated
      -- tab_size = 10,
      indicator = {
        icon = "▎", -- this should be omitted if indicator style is not 'icon'
        style = "none",
      },
      -- sort_by = 'insert_after_current',
      offsets = {
        {
          filetype = "NvimTree",
          text = "File Explorer",
          text_align = "center",
          separator = true
        }
      },
      style_preset = {
        require('bufferline').style_preset.no_italic,
        require('bufferline').style_preset.no_bold
      },
      left_trunc_marker = '«',
      right_trunc_marker = '»',
    },
  },
}
