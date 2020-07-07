let g:multi_cursor_start_word_key='<C-f>'
let g:multi_cursor_next_key='<C-f>'
let g:multi_cursor_prev_key='<C-p>'
let g:multi_cursor_skip_key='<C-s>'
let g:multi_cursor_quit_key='<Esc>'

function! Multiple_cursors_before()
    ALEToggle
    let s:old_ycm_whitelist = g:ycm_filetype_whitelist
    let g:ycm_filetype_whitelist = {}
    " call deoplete#custom#buffer_option('auto_complete', v:false)
endfunc
function! Multiple_cursors_after()
    ALEToggle
    let g:ycm_filetype_whitelist = s:old_ycm_whitelist
    " call deoplete#custom#buffer_option('auto_complete', v:true)
endfunc
