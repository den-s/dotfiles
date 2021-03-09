let g:coc_global_extensions = ['coc-tsserver']

" GoTo code navigation.
nmap <leader>gd <Plug>(coc-definition)
nmap <leader>gt <Plug>(coc-type-definition)
" nmap <silent> gi <Plug>(coc-implementation)
nmap <leader>gr <Plug>(coc-references)

" Remap keys for applying codeAction to the current line.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

function! SplitIfNotOpen(...)
  let fname = a:1
  let call = ''
  if a:0 == 2
    let fname = a:2
    let call = a:1
  endif
  let bufnum=bufnr(expand(fname))
  let winnum=bufwinnr(bufnum)
  if winnum != -1
    " Jump to existing split
    exe winnum . "wincmd w"
  else
    " Make new split as usual
    exe "vsplit " . fname
  endif
  " Execute the cursor movement command
  exe call
endfunction

command! -nargs=+ CocSplitIfNotOpen :call SplitIfNotOpen(<f-args>)
