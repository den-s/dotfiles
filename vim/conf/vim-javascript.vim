let g:javascript_plugin_flow = 1

nmap <silent> <C-s> <Plug>(jsdoc)
lef g:jsdoc_enable_es6 = 1
let g:javascript_plugin_jsdoc = 1
let g:jsdoc_access_descriptions = 2
let g:jsdoc_underscore_private = 1
let g:jsdoc_allow_input_prompt = 1
let g:jsdoc_input_description = 1

augroup javascript_folding
    au!
    au FileType javascript setlocal foldmethod=syntax
augroup END
