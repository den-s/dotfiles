set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
" let g:syntastic_javascript_checkers = ['jscs', 'eslint', 'jshint']
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_typescriptreact_checkers = ['eslint']
let g:syntastic_check_on_open = 0

let g:syntastic_aggregate_errors = 1
let g:syntastic_error_symbol = 'x'
let g:syntastic_warning_symbol = '!'
let g:syntastic_style_error_symbol = 'x'
let g:syntastic_style_warning_symbol = '!'
