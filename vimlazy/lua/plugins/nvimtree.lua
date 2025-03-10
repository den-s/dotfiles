return {
  'nvim-tree/nvim-tree.lua',
  dependencies = "nvim-tree/nvim-web-devicons",
  -- lazy = true,

  config = function()
    local nvim_tree = require("nvim-tree")

    local function on_attach(bufnr)
      local api = require('nvim-tree.api')

      local function opts(desc)
        return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
      end

      api.config.mappings.default_on_attach(bufnr)

      vim.keymap.set('n', 'l', api.node.open.edit, opts('Open'))
      vim.keymap.set('n', 'h', api.node.navigate.parent_close, opts('Close Directory'))
    end


    nvim_tree.setup({
      on_attach = on_attach,
      disable_netrw = true,
      -- hijack_netrw = true,
      -- open_on_tab = false,
      -- hijack_cursor = false,
      -- update_cwd = true,
      -- diagnostics = {
      --   enable = true,
      --   icons = {
      --     hint = "󰌶",
      --     info = "",
      --     warning = "󰀪",
      --     error = "󰅚",
      --   },
      -- },
      update_focused_file = {
        enable = true,
        update_cwd = true,
        ignore_list = {},
      },
      -- system_open = {
      --   cmd = nil,
      --   args = {},
      -- },
      -- filters = {
      --   dotfiles = false,
      --   custom = {},
      -- },
      git = {
        enable = true,
        ignore = true,
        timeout = 500,
      },
      -- actions = {
      --   open_file = {
      --     quit_on_open = false,
      --     window_picker = {
      --       enable = false,
      --     }
      --   },
      -- },
      -- view = {
      --   width = 30,
      --   side = "left",
      --   number = false,
      --   relativenumber = false,
      -- },
      -- trash = {
      --   cmd = "trash",
      --   require_confirm = true,
      -- },
      -- renderer = {
      --   highlight_opened_files = "all",
      --   icons = {
      --     glyphs = {
      --       default = "",
      --       symlink = "",
      --       git = {
      --         unstaged = "U",
      --         staged = "S",
      --         unmerged = "",
      --         renamed = "➜",
      --         untracked = "?",
      --         deleted = "",
      --         ignored = "◌",
      --       },
      --       folder = {
      --         default = "",
      --         open = "",
      --         empty = "",
      --         empty_open = "",
      --         symlink = "",
      --       },
      --     }
      --   }
      -- }
    })
  end,
}
