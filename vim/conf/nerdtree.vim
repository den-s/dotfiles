"NERDTree options {{{
" nmap <leader>tt :NERDTreeToggle<cr>
" inoremap <F4> <Esc>:NERDTreeToggle<cr>

" nmap <leader>tg :NERDTreeFind<cr>
" inoremap <F5> <Esc>:NERDTreeFind<cr>

" autocmd StdinReadPre * let s:std_in=1
" autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

let NERDTreeIgnore          =   ['\.pyc$','\.swp$']                 "ignore compiled python files
let NERDTreeMouseMode       =   3                                   "single-click to open files/nodes
let NERDTreeWinPos          =   'left'
let NERDTreeSplitVertical   =   1                                   "and open as vsplit
let NERDTreeChDirMode       =   2                                   "change working dir when I change root
let NERDTreeShowBookmarks   =   0


let NERDTreeDirArrowCollapsible = '▼'
let NERDTreeDirArrowExpandable = '▶'

" let NERDTreeDirArrowCollapsible = '└'
" let NERDTreeDirArrowExpandable = '├'

function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
 exec 'autocmd filetype nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
 exec 'autocmd filetype nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
endfunction

call NERDTreeHighlightFile('ini', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('md', 'blue', 'none', '#3366FF', '#151515')
call NERDTreeHighlightFile('yml', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('config', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('conf', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('json', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('html', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('styl', 'cyan', 'none', 'cyan', '#151515')
call NERDTreeHighlightFile('css', 'cyan', 'none', 'cyan', '#151515')
call NERDTreeHighlightFile('scss', 'cyan', 'none', 'cyan', '#151515')
call NERDTreeHighlightFile('coffee', 'Red', 'none', 'red', '#151515')
call NERDTreeHighlightFile('js', 'Red', 'none', '#ffa500', '#151515')
call NERDTreeHighlightFile('ts', 'Red', 'none', 'red', '#151515')
call NERDTreeHighlightFile('tsx', 'Magenta', 'none', 'magenta', '#151515')
call NERDTreeHighlightFile('php', 'Magenta', 'none', '#ff00ff', '#151515')
"}}}
