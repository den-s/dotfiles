let g:UltiSnipsExpandTrigger="<C-l>"
let g:UltiSnipsJumpForwardTrigger="<C-l>"
let g:UltiSnipsJumpBackwardTrigger="<C-h>"

let g:ycm_max_num_candidates = 10
let g:ycm_collect_identifiers_from_comments_and_strings = 1

" let g:ycm_auto_trigger=1
" let g:ycm_add_preview_to_completeopt=1
" let g:ycm_autoclose_preview_window_after_completion = 1

nmap <leader>g :YcmCompleter GoTo<cr>
