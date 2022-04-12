""* * * * * * * * * * *
" *   _______ ______  *
" *  |  _____/ _____| *
" *  | |    / /\      *
" *  | |    \ \|___   *
" *  | |     \___  \  *
" *  | |     | |  \ \ *
" *  | |____/_/___/ / *
" *  |______|______/  *
" *                   *
" * * * * * * * * * * *

set encoding=utf-8
scriptencoding utf-8

set splitbelow
set splitright

" Sets how many lines of history VIM has to remember
set history=700
set undolevels=700

" Enable filetype plugins
filetype plugin on
filetype indent on

" 1 tab == 2 spaces
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab

" Set 7 lines to the cursor - when moving vertically using j/k
set so=7

" Turn on the WiLd menu
set wildmenu

" Always show current position
set ruler

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

"set et
set wrap
set linebreak
"set nolist
set ai "Auto indent
set si "Smart indent

" Show matching brackets when text indicator is over them
set showmatch

" How many tenths of a second to blink when matching brackets
set mat=2

" Highlight search results
set hlsearch

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases
set smartcase

set number
set fo-=t " don't automatically wrap text when typing

" Makes search act like search in modern browsers
set incsearch

" Set to auto read when a file is changed from the outside
set autoread

" Don't redraw while executing macros (good performance config)
set lazyredraw

set ttyfast

syntax sync minlines=256
set foldnestmax=2

" No annoying sound on errors
set t_vb=
set tm=500
set noerrorbells
set novisualbell

set foldcolumn=3
set foldmethod=indent

set list

set listchars=tab:▸·,extends:…,precedes:«,extends:»,trail:·,eol:¬
let &showbreak = '↪ '

set ffs=unix,dos,mac
set fencs=utf-8,cp1251,koi8-r,ucs-2,cp866

let mapleader = ","
let g:mapleader = ","

set spelllang=ru_ru,en_us

" Toggle spellchecking
function! ToggleSpellCheck()
  set spell!
  if &spell
    echo "Spellcheck is ON"
  else
    echo "Spellcheck is OFF"
  endif
endfunction

syntax enable
set background=dark

" Enable if vim don't colorize
" colorscheme hybrid

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"=> Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowb
set noswapfile

" Ignore compiled files
set wildignore=*.o,*~,*.pyc,node_modules,venv,bower_components,*/.DS_Store
if has("win16") || has("win32")
  set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
else
  set wildignore+=.git\*,.hg\*,.svn\*
endif

set laststatus=2
set relativenumber

" Make tab in v mode work like I think it should (keep highlighting):

set updatetime=300

" Better navigating through omnicomplete option list
" See
" http://stackoverflow.com/questions/2170023/how-to-map-keys-for-popup-menu-in-vim

set completeopt=menu,menuone,noselect

function! OmniPopup(action)
    if pumvisible()
        if a:action == 'j'
            return "\<C-N>"
        elseif a:action == 'k'
            return "\<C-P>"
        endif
    endif
    return a:action
endfunction

augroup vimrc
  autocmd!
  autocmd bufwritepost .vimrc source $MYVIMRC
augroup end

" For conceal markers.
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif

if has('nvim')
  call plug#begin('~/.config/nvim/plugins')
else
  call plug#begin('~/.vim/plugins')
endif

set termguicolors

" Mappings {
nmap <leader>w :wa!<cr>

nmap <leader>q :bd<cr>
" nmap <c-h> :tabprevious<cr>
" nmap <c-l> :tabnext<cr>
" nmap <c-n> :tabnew<cr>
nmap <c-h> :bp<cr>
nmap <c-l> :bn<cr>
nmap <c-n> :tabnew<cr>
nmap <leader>tc :tabclose<cr>

nmap <Up> <C-W><Up>
nmap <Down> <C-W><Down>
nmap <Left> <C-W><Left>
nmap <Right> <C-W><Right>

nmap <leader>rc :source ~/.config/nvim/init.vim<CR>
nmap <leader>rr :syntax on<CR> :syntax sync fromstart<CR>:redraw!<CR>

nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
nnoremap <silent><Leader>ss :call ToggleSpellCheck()<CR>

nnoremap <leader>tt2 :set tabstop=2 shiftwidth=2 expandtab<CR>
nnoremap <leader>tt4 :set tabstop=4 shiftwidth=4 expandtab<CR>

inoremap <silent><C-j> <C-R>=OmniPopup('j')<CR>
inoremap <silent><C-k> <C-R>=OmniPopup('k')<CR>

" ctags
nmap <leader>] [I:let nr = input("Which one: ")<Bar>exe "normal " . nr ."[\t"<CR>
nnoremap <silent><Leader><C-]> <C-w><C-]><C-w>T
" -------

" diffs
nmap <leader>6 :diffget LOCAL<cr>
nmap <leader>7 :diffget BASE<cr>
nmap <leader>8 :diffget REMOTE<cr>

nmap <leader>g6 :diffget //2<cr>
nmap <leader>g8 :diffget //3<cr>
" -------

vmap <tab> >gv
vmap <s-tab> <gv

vmap J :m '>+1<CR>gv=gv
vmap K :m '<-2<CR>gv=gv
vmap H <gv
vmap L >gv

imap <C-p> <Nop>

nmap <leader>r2 :vertical resize 30<cr>
nmap <leader>r3 :vertical resize 40<cr>
nmap <leader>r4 :vertical resize 50<cr>
nmap <leader>r5 :vertical resize 60<cr>
nmap <leader>r= :vertical resize +5<cr>
nmap <leader>r- :vertical resize -5<cr>

noremap <C-c> <C-a>
nmap <leader>dt :tab split<cr>
" }

Plug 'w0ng/vim-hybrid'
Plug 'whatyouhide/vim-gotham'
Plug 'arcticicestudio/nord-vim'
Plug 'lifepillar/vim-gruvbox8'

" Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'preservim/nerdcommenter'
Plug 'mattn/emmet-vim'
Plug 'jonathanfilip/vim-lucius'
Plug 'tpope/vim-unimpaired'
Plug 'mileszs/ack.vim'
Plug 'groenewege/vim-less'
Plug 'diepm/vim-rest-console'
Plug 'hesselbom/vim-hsftp'
" Plug 'Raimondi/delimitMate'
Plug 'windwp/nvim-autopairs'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'plasticboy/vim-markdown'
Plug 'hail2u/vim-css3-syntax'
" Plug 'w0rp/ale'
Plug 'SirVer/ultisnips'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
" Plug 'itchyny/lightline.vim'
" Plug 'mhinz/vim-signify'
" Plug 'airblade/vim-gitgutter'
Plug 'vim-scripts/indentpython.vim'
" Plug 'chemzqm/vim-jsx-improve'
" Plug 'ap/vim-css-color'
Plug 'tpope/vim-repeat'
Plug 'junegunn/goyo.vim'
" Plug 'sheerun/vim-polyglot'
Plug 'neovim/nvim-lspconfig'
" Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-lualine/lualine.nvim'
Plug 'norcalli/nvim-colorizer.lua'
Plug 'lewis6991/gitsigns.nvim'
Plug 'akinsho/bufferline.nvim'
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
Plug 'kyazdani42/nvim-tree.lua'
Plug 'williamboman/nvim-lsp-installer'

" Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}

call plug#end()


" Plugins configs {

" Ack {
  nmap <leader>a :Ack ""<left>
  nmap <leader>A :Ack <C-r><C-w><CR>
  let g:ackprg = 'rg -S --no-heading --vimgrep'
" }

" vim-rest-console {
  let g:vrc_show_command = 1
" }

" Emmet {
  let g:user_emmet_expandabbr_key='<c-\>'
  let g:user_emmet_mode='i'
  let g:user_emmet_settings = {
        \  'javascript' : {
        \      'extends' : 'jsx',
        \  },
        \  'typescript' : {
        \      'extends' : 'tsx',
        \  },
        \}
" }
"
" UltiSnips {
  let g:UltiSnipsExpandTrigger="<C-l>"
  let g:UltiSnipsJumpForwardTrigger="<C-l>"
  let g:UltiSnipsJumpBackwardTrigger="<C-h>"

  let g:UltiSnipsSnippetsDir = "~/.config/nvim/UltiSnips/"
  "
  " imap <C-l> <Plug>(coc-snippets-expand)
  " let g:coc_snippet_next = '<c-l>'
  " imap <C-l> <Plug>(coc-snippets-expand-jump)
" }
"
" telescope {
  nmap <leader>ff <cmd>Telescope find_files<cr>
  nmap <leader>fg <cmd>Telescope live_grep<cr>
  nmap <leader>fb <cmd>Telescope git_branches<cr>
  nmap <leader>fc <cmd>Telescope git_bcommits<cr>
  nmap <leader>fh <cmd>Telescope help_tags<cr>
" }
"
" {
  nmap <leader>tg :NvimTreeFindFileToggle<cr>
  nmap <leader>tt :NvimTreeToggle<cr>
" }

" source ~/.config/nvim/conf/gruvbox.vim
" source ~/.config/nvim/conf/nerdtree.vim
source ~/.config/nvim/conf/pymode.vim
" source ~/.config/nvim/conf/gitgutter.vim
" source ~/.config/nvim/conf/signify.vim
" source ~/.config/nvim/conf/easymotion.vim
source ~/.config/nvim/conf/surround.vim
" source ~/.config/nvim/conf/youcompleteme.vim
" source ~/.config/nvim/conf/deoplete.vim
" source ~/.config/nvim/conf/vim-javascript.vim
" source ~/.config/nvim/conf/ale.vim
source ~/.config/nvim/conf/lightline.vim
source ~/.config/nvim/conf/fzf.vim
source ~/.config/nvim/conf/nerdcommenter.vim
source ~/.config/nvim/conf/delimmate.vim
" source ~/.config/nvim/conf/auto-pairs.vim
source ~/.config/nvim/conf/vim-viasual-multi.vim
source ~/.config/nvim/conf/nord.vim
" source ~/.config/nvim/conf/coc.vim
source ~/.config/nvim/conf/goyo.vim

luafile ~/.config/nvim/conf/cmp.lua
luafile ~/.config/nvim/conf/lsp-config.lua
luafile ~/.config/nvim/conf/telescope.lua
luafile ~/.config/nvim/conf/lualine.lua
luafile ~/.config/nvim/conf/nvim-colorizer.lua
luafile ~/.config/nvim/conf/gitsigns.lua
luafile ~/.config/nvim/conf/bufferline.lua
luafile ~/.config/nvim/conf/nvimtree.lua
luafile ~/.config/nvim/conf/lsp-installer.lua
luafile ~/.config/nvim/conf/autopairs.lua

" colorscheme gruvbox8
colorscheme tokyonight

" } Plugins configs end
