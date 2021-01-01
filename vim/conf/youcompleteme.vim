let g:ycm_max_num_candidates = 10
" let g:ycm_collect_identifiers_from_comments_and_strings = 1

let b:ycm_hover=''
let b:ycm_auto_hover=''
" let s:ycm_hover_popup = -1
let g:ycm_echo_current_diagnostic=0
set completeopt-=preview
let g:ycm_add_preview_to_completeopt=0
let g:ycm_goto_buffer_command='split-or-existing-window'

" let g:ycm_auto_trigger=1
" let g:ycm_add_preview_to_completeopt=1
" let g:ycm_autoclose_preview_window_after_completion = 1

let g:ycm_show_diagnostics_ui = 1
let g:ycm_enable_diagnostic_signs = 0
let g:ycm_enable_diagnostic_highlighting = 0

nmap <leader>gd :tab tab YcmCompleter GoToDefinition<cr>
nmap <leader>vgd :rightbelow vertical YcmCompleter GoToDefinition<cr>
nmap <leader>gr :YcmCompleter GoToReferences<cr>
nmap <leader>oi :YcmCompleter OrganizeImports<cr>
nmap <leader>tp <plug>(YCMHover)
