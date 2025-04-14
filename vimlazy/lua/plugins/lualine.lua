vim.g["airline#extensions#tabline#enabled"] = 0

local hide_in_width = function()
  return vim.fn.winwidth(0) > 95
end

local hide_branch_in_width = function()
  return vim.fn.winwidth(0) < 95
end

local diagnostics = {
  "diagnostics",
  sources = { "nvim_diagnostic" },
  sections = { "error", "warn", "hint" },
  symbols = { error = "🞅 ", warn = "🞅 ", hint = "🞅 " },
  update_in_insert = false,
  -- cond = hide_in_width,
}

local diff = {
  "diff",
  symbols = { added = "+", modified = "~ ", removed = "- " }, -- changes diff symbols
  -- cond = hide_in_width,
  colored = false,
}

local mode = {
  "mode",
  fmt = function(str)
    local modes = {
      ["NORMAL"] = "N",
      ["INSERT"] = "I",
      ["V-LINE"] = "V",
      ["VISUAL"] = "V",
      ["V-BLOCK"] = "V",
      ["REPLACE"] = "R",
      ["COMMAND"] = ">_",
    }
    return modes[str]
  end,
}

local tabs = {
  "tabs",
  -- mode=1,

  show_modified_status = false,  -- Shows a symbol next to the tab name if the file has been modified.

  -- use_mode_colors = true,
  -- symbols = {
  --   modified = ' ●',  -- Text to show when the file is modified.
  -- },
  mode = 0,
}

local lsp_status = {
  'lsp_status',
  cond = hide_in_width,
  icon = ' ', -- f013
  symbols = {
    -- Standard unicode symbols to cycle through for LSP progress:
    spinner = { '⠋', '⠙', '⠹', '⠸', '⠼', '⠴', '⠦', '⠧', '⠇', '⠏' },
    -- Standard unicode symbol for when LSP is done:
    done = '✓',
    -- Delimiter inserted between LSP names:
    separator = ' ',
  },
  -- List of LSP names to ignore (e.g., `null-ls`):
  ignore_lsp = {'copilot'},
}

local filetype = {
  "filetype",
  icons_enabled = false,
  -- icon_only = true,
  -- icon = nil,
  cond = hide_in_width,
}

local filetype_icon = {
  "filetype",
  icon_only = true,
  -- icon = nil,
  -- cond = hide_in_width,
}

local branch = {
  "branch",
  icons_enabled = true,
  icon = "",
  fmt = function(str)
    local result = str

    if hide_branch_in_width() and string.len(str) > 10 then
      result = string.format("%s...", string.sub(str, 0, 10))
    end
    return result
  end,
  cond = hide_in_width,
}

local location = {
  "location",
  padding = 0,
}

local progress = {
  "progress",
  padding = { left = 1, right = 1 },
}

local filename = {
  "filename",
  padding = 0,
  -- path = 1,
  fmt = function(str)
    local resp = str:gsub("%[%+%]", " ●")
    return resp:gsub("%[%-%]", " ")
  end,
}

local filepath = {
  "filename",
  path = 3,
  fmt = function(str)
    local resp = str:gsub("%[%+%]", " ●")
    return resp:gsub("%[%-%]", " ")
  end,
}

local fileformat = {
  "fileformat",
  symbols = {
    unix = "", -- e712
    dos = "", -- e70f
    mac = "", -- e711
  },
}
-- local actived_venv = {
--   "actived_venv",
--   fmt = function()
--     local venv_name = require("venv-selector").get_active_venv()
--     if venv_name ~= nil then
--       return string.format("(%s)", string.gsub(venv_name, ".*/pypoetry/virtualenvs/", "(poetry) "))
--     end
--   end,
-- }

local is_format = {
  "fileformat",
  fmt = function(str)
    local icon_enable_all = "F"
    local icon_enabele_signs = "FS"

    if vim.g.disable_autoformat == false then
      return icon_enable_all
    elseif vim.g.disable_autoformat_signs == false then
      return icon_enabele_signs
    end
    return ""
  end
}

return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  opts = {
    --[[add your custom lualine config here]]
    options = {
      theme = "kanagawa",
      icons_enabled = true,
      component_separators = { left = "", right = "" },
      section_separators = { left = "", right = "" },
      disabled_filetypes = { "fugitive", "vim-plug", "NvimTree" },
      always_divide_middle = true
    },
    sections = {
      lualine_a = { mode },
      lualine_b = { branch, diff },
      lualine_c = { filetype_icon, filename },
      -- lualine_x = { "encoding", "fileformat", "filetype" },
      lualine_x = { is_format, diagnostics, filetype },
      lualine_y = { tabs },
      lualine_z = { location, progress },
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = { filepath },
      lualine_x = {},
      lualine_y = {},
      lualine_z = {},
    },
    tabline = {},
    extensions = { "fugitive", "mason", "nvim-tree" },
  },
}
