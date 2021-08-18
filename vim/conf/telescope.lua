require('telescope').setup{
  defaults = {
    borderchars = { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
    file_ignore_patterns={'%.gif', '%.png', '%.jpg'}
  }
}

local opts = { noremap=true, silent=true }

local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

buf_set_keymap('n', 'ff', '<cmd>Telescope find_files<cr>', opts)
buf_set_keymap('n', 'fg', '<cmd>Telescope live_grep<cr>', opts)
buf_set_keymap('n', 'fb', '<cmd>Telescope git_branches<cr>', opts)
buf_set_keymap('n', 'fc', '<cmd>Telescope git_bcommits<cr>', opts)
buf_set_keymap('n', 'fh', '<cmd>Telescope help_tags<cr>', opts)
