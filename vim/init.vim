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
let &showbreak = '↳ '

set ffs=unix,dos,mac
set fencs=utf-8,cp1251,koi8-r,ucs-2,cp866

" Disable add a new lane at the end of the file
" set numberwidth=2

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

" Set extra options when running in GUI mode
if has("gui_running")
  set guioptions-=T
  set guioptions-=e
  set guioptions-=m
  set guioptions-=L
  set guioptions-=r
  set guioptions-=b
  set guitablabel=%M\ %t
  set guifont=Fira\ Code\ Light:h15
  set linespace=3

  if has('mac')
    set macligatures
    if system("osascript -e 'tell application \"Finder\" to get bounds of window of desktop' | cut -d ' ' -f 4") > 900
      " set guifont=Sauce\ Code\ Pro\ Nerd\ Font\ Complete:h17
      " set guifont=Hack\ Regular:h17
      set guifont=Fira\ Code\ Light:h17
    else
      " set guifont=Sauce\ Code\ Pro\ Nerd\ Font\ Complete:h14
      " set guifont=Hack\ Regular:h15
      set guifont=Fira\ Code\ Light:h15
    endif
  endif
endif

syntax enable
colorscheme gruvbox8
set background=dark

" set ambiwidth="double"
" set t_Co=256
" set termguicolors

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
" set relativenumber

" Make tab in v mode work like I think it should (keep highlighting):

set updatetime=300

" Better navigating through omnicomplete option list
" See
" http://stackoverflow.com/questions/2170023/how-to-map-keys-for-popup-menu-in-vim
set completeopt=longest,menuone
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

function! g:ToggleBackground()
  if &background != 'dark'
    colorscheme gotham
    set background=dark
  else
    colorscheme lucius
    set background=light
  endif
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

" Mappings {
nmap <leader>w :wa!<cr>

nmap <leader>q :bd<cr>
nmap <c-h> :tabprevious<cr>
nmap <c-l> :tabnext<cr>
nmap <c-n> :tabnew<cr>
nmap <leader>tc :tabclose<cr>

nmap <Up> <C-W><Up>
nmap <Down> <C-W><Down>
nmap <Left> <C-W><Left>
nmap <Right> <C-W><Right>

nmap <leader>tj :set ft=javascript<cr>
nmap <leader>tjr :set ft=javascriptreact<cr>
nmap <leader>tts :set ft=typescript<cr>

nmap <leader>rc :source ~/.config/nvim/init.vim<CR>
nmap <leader>rr :syntax on<CR> :syntax sync fromstart<CR>:redraw!<CR>

nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
nnoremap <silent><Leader>ss :call ToggleSpellCheck()<CR>

nnoremap <leader>bg :call g:ToggleBackground()<CR>

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

nmap <leader>gl :diffget //2<cr>
nmap <leader>gr :diffget //3<cr>
" -------

vmap <tab> >gv
vmap <s-tab> <gv

vmap J :m '>+1<CR>gv=gv
vmap K :m '<-2<CR>gv=gv
vmap H <gv
vmap L >gv

imap <C-p> <Nop>
" }

Plug 'w0ng/vim-hybrid'
Plug 'whatyouhide/vim-gotham'
Plug 'arcticicestudio/nord-vim'
Plug 'lifepillar/vim-gruvbox8'
" Plug 'morhetz/gruvbox'
Plug 'shinchu/lightline-gruvbox.vim'

Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'preservim/nerdcommenter'
Plug 'mattn/emmet-vim'
Plug 'jonathanfilip/vim-lucius'
Plug 'tpope/vim-unimpaired'
Plug 'honza/vim-snippets'
Plug 'mileszs/ack.vim'
Plug 'groenewege/vim-less'
Plug 'diepm/vim-rest-console'
Plug 'hesselbom/vim-hsftp'
Plug 'Raimondi/delimitMate'
" Plug 'jiangmiao/auto-pairs'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'plasticboy/vim-markdown'
Plug 'hail2u/vim-css3-syntax'
Plug 'w0rp/ale'
Plug 'SirVer/ultisnips'
Plug 'junegunn/fzf', { 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
Plug 'itchyny/lightline.vim'
" Plug 'mhinz/vim-signify'
Plug 'airblade/vim-gitgutter'
Plug 'vim-scripts/indentpython.vim'
Plug 'chemzqm/vim-jsx-improve'
Plug 'ap/vim-css-color'
Plug 'tpope/vim-repeat'
Plug 'junegunn/goyo.vim'
" Plug 'sheerun/vim-polyglot'
if has('nvim')
  " Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }
  " Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  " Plug 'Shougo/deoplete.nvim'
  " Plug 'Shougo/defx.nvim'
  " Plug 'roxma/nvim-yarp'
  " Plug 'roxma/vim-hug-neovim-rpc'
endif
" Plug 'leafgarland/typescript-vim'
" Plug 'peitalin/vim-jsx-typescript'
Plug 'justinmk/vim-sneak'
" Plug 'neovim/nvim-lspconfig'

function! BuildYCM(info)
  " info is a dictionary with 3 fields
  " - name:   name of the plugin
  " - status: 'installed', 'updated', or 'unchanged'
  " - force:  set on PlugInstall! or PlugUpdate!
  if a:info.status == 'installed' || a:info.force
    !./install.py --ts-completer
  endif
endfunction

Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}

" Plug 'Valloric/YouCompleteMe', { 'do': function('BuildYCM') }

call plug#end()

" Plugins configs {

" Ack {
  nmap <leader>a :tab split<CR>:Ack ""<left>
  nmap <leader>A :tab split<CR>:Ack <C-r><C-w><CR>
  let g:ackprg = 'rg -S --no-heading --vimgrep'
" }

" vim-rest-console {
  let g:vrc_show_command = 1
" }

" CtrlP {
  " nmap <C-i> :CtrlPLine<CR>
  " let g:ctrlp_user_command = 'rg --files %s'
  " nmap <C-b> :CtrlPBuffer<CR>
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

source ~/.config/nvim/conf/gruvbox.vim
source ~/.config/nvim/conf/nerdtree.vim
source ~/.config/nvim/conf/pymode.vim
source ~/.config/nvim/conf/gitgutter.vim
" source ~/.config/nvim/conf/signify.vim
" source ~/.config/nvim/conf/easymotion.vim
source ~/.config/nvim/conf/surround.vim
" source ~/.config/nvim/conf/multicursor.vim
" source ~/.config/nvim/conf/youcompleteme.vim
" source ~/.config/nvim/conf/deoplete.vim
source ~/.config/nvim/conf/vim-javascript.vim
source ~/.config/nvim/conf/ale.vim
" source ~/.config/nvim/conf/syntastic.vim
source ~/.config/nvim/conf/lightline.vim
source ~/.config/nvim/conf/fzf.vim
source ~/.config/nvim/conf/nerdcommenter.vim
source ~/.config/nvim/conf/delimmate.vim
" source ~/.config/nvim/conf/defx.vim
" source ~/.config/nvim/conf/auto-pairs.vim
source ~/.config/nvim/conf/vim-viasual-multi.vim
source ~/.config/nvim/conf/sneak.vim
source ~/.config/nvim/conf/nord.vim
source ~/.config/nvim/conf/coc.vim
source ~/.config/nvim/conf/goyo.vim
" source ~/.config/nvim/conf/statusline.vim

" } Plugins configs end
