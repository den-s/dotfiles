local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
	return
end

local hide_in_width = function()
	return vim.fn.winwidth(0) > 80
end

local hide_branch_in_width = function()
	return vim.fn.winwidth(0) < 95
end

local diagnostics = {
	"diagnostics",
	sources = { "nvim_diagnostic" },
	sections = { "error", "warn" },
	-- symbols = { error = "󰅚", warn = "󰀪" },
	update_in_insert = false,
  cond = hide_in_width,
}

local diff = {
	"diff",
	symbols = { added = " ", modified = " ", removed = " " }, -- changes diff symbols
  cond = hide_in_width,
  colored = false
}

local mode = {
	"mode",
	fmt = function(str)
    local modes = { ["NORMAL"] = "N", ["INSERT"] = "I", ["V-LINE"] = "V", ["VISUAL"] = "V", ["V-BLOCK"] = "V", ["REPLACE"] = "R", ["COMMAND"] = ">_" }
    return modes[str]
	end,
}

local filetype = {
	"filetype",
	icons_enabled = false,
	icon = nil,
  cond = hide_in_width,
}

local branch = {
	"branch",
	icons_enabled = true,
  icon = "",
  fmt = function(str)
    local result = str

    if hide_branch_in_width() and string.len(str) > 10 then
      result = string.format('%s...', string.sub(str, 0, 10))
    end
    return result
  end
}

local location = {
  "location",
  padding = 0,
}

local progress = {
  "progress",
  padding = { left = 1, right = 1},
}

local filename = {
  "filename",
  -- path = 1,
  fmt = function(str)
    local resp = str:gsub("%[%+%]", " ●")
    return resp:gsub("%[%-%]", " ")
  end
}

local filepath = {
  "filename",
  path = 3,
  fmt = function(str)
    local resp = str:gsub("%[%+%]", " ●")
    return resp:gsub("%[%-%]", " ")
  end
}

local fileformat = {
  'fileformat',
  symbols = {
    unix = '', -- e712
    dos = '',  -- e70f
    mac = '',  -- e711
  }
}

lualine.setup({
  options = {
    theme = "catppuccin",
    icons_enabled = true,
    component_separators = { left = "", right = "" },
    section_separators = { left = '', right = '' },
    disabled_filetypes = {'fugitive', 'vim-plug', 'NvimTree'},
    always_divide_middle = true,
  },
  sections = {
    lualine_a = { mode },
    lualine_b = { branch, diff },
    lualine_c = { filename },
    -- lualine_x = { "encoding", "fileformat", "filetype" },
    lualine_x = { diagnostics },
    lualine_y = { filetype, fileformat },
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
  extensions = {'fugitive', 'mason', 'nvim-tree'},
})
