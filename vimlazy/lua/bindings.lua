vim.g.mapleader = " "

vim.keymap.set("n", "<leader>w", ":wa!<cr>")
vim.keymap.set("n", "<leader>q", ":bd<cr>")

vim.keymap.set("n", "<c-h>", ":tabprevious<cr>")
vim.keymap.set("n", "<c-l>", ":tabnext<cr>")

--[[ " nmap <c-n> :tabnew<cr> ]]

-- vim.keymap.set("n", "<c-h>", ":bp<cr>")
-- vim.keymap.set("n", "<c-l>", ":bn<cr>")

vim.keymap.set("n", "<c-n>", ":tabnew<cr>")

vim.keymap.set("n", "<leader>tc", ":tabclose<cr>")

vim.keymap.set("n", "<leader>rc", ":source ~/.config/nvim/init.vim<CR>")

 --[[ " nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR> ]]
vim.keymap.set("n", "<silent><Leader>ss", ":call ToggleSpellCheck()<CR>")

vim.keymap.set("n", "<leader>tt2", ":set tabstop=2 shiftwidth=2 expandtab<CR>")
vim.keymap.set("n", "<leader>tt4", ":set tabstop=4 shiftwidth=4 expandtab<CR>")

vim.keymap.set("i", "<silent><C-j>", "<C-R>=OmniPopup('j')<CR>")
vim.keymap.set("i", "<silent><C-k>", "<C-R>=OmniPopup('k')<CR>")

 --[[ " diffs ]]
vim.keymap.set("n", "<leader>6", ":diffget LOCAL<cr>")
vim.keymap.set("n", "<leader>7", ":diffget BASE<cr>")
vim.keymap.set("n", "<leader>8", ":diffget REMOTE<cr>")

vim.keymap.set("n", "<leader>g6", ":diffget //2<cr>")
vim.keymap.set("n", "<leader>g8", ":diffget //3<cr>")

vim.keymap.set("v", "<tab>", ">gv")
vim.keymap.set("v", "<s-tab>", "<gv")

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("v", "H", "<gv")
vim.keymap.set("v", "L", ">gv")

vim.keymap.set("n", "<C-c>", "<C-a>")

--[[ Plugins configs ]]

--[[ Ack ]]
vim.keymap.set("n", "<leader>a", ":Ack <left>")
vim.keymap.set("n", "<leader>A", ":Ack <C-r><C-w><CR>")


--[[ " UltiSnips { ]]
--[[ vim.keymap.set(" ", "let", "g:UltiSnipsExpandTrigger="<C-l>"") ]]
--[[ vim.keymap.set(" ", "let", "g:UltiSnipsJumpForwardTrigger="<C-l>"") ]]
--[[ vim.keymap.set(" ", "let", "g:UltiSnipsJumpBackwardTrigger="<C-h>"") ]]
--[[]]
--[[ vim.keymap.set(" ", "let", "g:UltiSnipsSnippetsDir = "~/.config/nvim/UltiSnips/"") ]]

 --[[ telescope ]]
-- vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>")
-- vim.keymap.set("n", ";", "<cmd>Telescope find_files<cr>")
-- vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>")
-- vim.keymap.set("n", "<leader>fb", "<cmd>Telescope git_branches<cr>")
-- vim.keymap.set("n", "<leader>fc", "<cmd>Telescope git_bcommits<cr>")
-- vim.keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>")

vim.keymap.set("n", "<leader>tg", ":NvimTreeFindFileToggle<cr>")
vim.keymap.set("n", "<leader>tt", ":NvimTreeToggle<cr>")
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")
vim.keymap.set("n", "<leader>to", ":split term://fish<cr>")
