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
	symbols = { error = " ", warn = " " },
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
  padding = { left = 0, right = 1},
}

local filename = {
  "filename",
  fmt = function(str)
    local resp = str:gsub("%[%+%]", " ●")
    return resp:gsub("%[%-%]", " ")
  end
}

lualine.setup({
	options = {
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
    lualine_y = { filetype },
lualine_z = { location, progress },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
    lualine_c = { filename },
		lualine_x = { "location" },
		lualine_y = {},
		lualine_z = {},
	},
	tabline = {},
	extensions = {},
})
