let g:ale_linters = {
\   'python': ['pylint', 'flake8'],
\   'javascript': ['standard'],
\   'javascript.jsx': ['standard'],
\}

" let g:ale_fix_on_save = 1

let g:ale_history_enabled = 0
" let g:ale_lint_on_text_changed = 'normal'
" let g:ale_lint_on_enter = 0
let g:ale_lint_delay = 300
let g:ale_linters_explicit = 1
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%severity%][%linter%] %s'

let g:ale_sign_error = '✘'
let g:ale_sign_info = 'i'
let g:ale_sign_style_error = '✘'
let g:ale_sign_style_warning = 'i'
let g:ale_sign_warning = 'i'

" nnoremap <leader>st :SyntasticToggleMode<CR>
map <leader>st :ALEToggle<CR>
