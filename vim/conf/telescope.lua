require('telescope').setup{
  defaults = {
    file_ignore_patterns={'%.gif', '%.png', '%.jpg'},
  }
}

local opts = { noremap=true, silent=true }

local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
