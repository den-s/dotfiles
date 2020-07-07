let g:signify_vcs_list = [ 'git' ]

let g:signify_update_on_bufenter    = 0

let g:signify_sign_change = '~'

let g:signify_sign_weight = 'none'

nmap <leader>hp :SignifyHunkDiff<cr>
nmap <leader>hu :SignifyHunkUndo<cr>

highlight SignifySignAdd    ctermfg=magenta  ctermbg=NONE    guifg=#2aa889 guibg=#11151c
highlight SignifySignDelete ctermfg=red    ctermbg=NONE    guifg=#d26937 guibg=#11151c
highlight SignifySignChange ctermfg=cyan   ctermbg=NONE    guifg=#195466 guibg=#11151c
