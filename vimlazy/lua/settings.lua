vim.opt.termguicolors = true
vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2

vim.opt.so = 7

vim.opt.ruler = true

--[[ vim.opt.backspace={'eol', 'start', 'indent'} ]]
--[[ vim.opt.whichwrap+="<,>,h,l" ]]

vim.opt.et = true
vim.opt.wrap = true
vim.opt.linebreak = true
-- vim.opt.ai = true
-- vim.opt.si = true

vim.opt.showmatch = true

-- vim.opt.mat=2

vim.opt.hlsearch = true

vim.opt.ignorecase = true

vim.opt.smartcase = true

vim.opt.number = true

vim.opt.incsearch = true

vim.opt.autoread = true

vim.opt.lazyredraw = true

vim.opt.ttyfast = true

vim.opt.list = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.listchars = { tab = "▸·", precedes = "«", extends = "»", trail = "·", eol = '¬' }
vim.opt.showbreak = "↪ "

vim.opt.spelllang = { "ru_ru", "en_us" }

-- vim.opt.background="dark"

vim.opt.laststatus = 2
vim.opt.relativenumber = true
vim.opt.updatetime = 500

-- vim.opt.completeopt={"menu","menuone","noselect"}

vim.g.ackprg = "rg -S  --no-heading --vimgrep"

vim.opt.fillchars = "eob: "

vim.o.showtabline = 0

-- vim.opt.foldmethod = "expr"
-- vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
-- -- vim.opt.foldtext = ""
-- vim.opt.foldnestmax = 4
-- vim.opt.foldlevel = 99
-- vim.opt.foldlevelstart = 1
--
-- vim.api.nvim_create_autocmd("FileType", {
--     pattern = "TelescopeResults",
--     command = "setlocal nofoldenable"
-- })
vim.api.nvim_create_autocmd("FileType", {
    pattern = "dbui",
    command = "setlocal nofoldenable"
})

-- vim.g.vrc_show_command = 1
