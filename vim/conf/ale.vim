let g:ale_linters = {
\   'python': ['pylint', 'flake8'],
\   'javascript': ['eslint'],
\   'javascriptreact': ['eslint'],
\   'typescriptreact': ['tsserver', 'eslint'],
\   'typescript': ['tsserver', 'eslint'],
\}

let g:ale_fixers = {
  \ 'typescriptreact': ['prettier', 'remove_trailing_lines', 'trim_whitespace'],
  \ 'typescript': ['prettier', 'remove_trailing_lines', 'trim_whitespace'],
\}


let g:ale_fix_on_save = 0
" let g:ale_disable_lsp = 1

nmap <leader>af :ALEFix<CR>

" let g:ale_lint_on_text_changed = 'never'
" let g:ale_lint_on_insert_leave = 0
" let g:ale_lint_on_enter = 0
let g:ale_history_enabled = 0
let g:ale_lint_delay = 0

let g:ale_linters_explicit = 1
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%severity%][%linter%] %s'

let g:ale_sign_error = 'E'
let g:ale_sign_info = 'I'
let g:ale_sign_style_error = 'E'
let g:ale_sign_style_warning = 'W'
let g:ale_sign_warning = 'W'

" nnoremap <leader>st :SyntasticToggleMode<CR>
map <leader>st :ALEToggle<CR>
