map ' <Plug>Sneak_;
map " <Plug>Sneak_,

nnoremap <silent> f :<C-U>call sneak#wrap('',           1, 0, 1, 1)<CR>
nnoremap <silent> F :<C-U>call sneak#wrap('',           1, 1, 1, 1)<CR>
xnoremap <silent> f :<C-U>call sneak#wrap(visualmode(), 1, 0, 1, 1)<CR>
xnoremap <silent> F :<C-U>call sneak#wrap(visualmode(), 1, 1, 1, 1)<CR>
onoremap <silent> f :<C-U>call sneak#wrap(v:operator,   1, 0, 1, 1)<CR>
onoremap <silent> F :<C-U>call sneak#wrap(v:operator,   1, 1, 1, 1)<CR>

" nnoremap <silent> s :<C-U>call sneak#wrap('',           3, 0, 2, 1)<CR>
" nnoremap <silent> S :<C-U>call sneak#wrap('',           3, 1, 2, 1)<CR>
" xnoremap <silent> s :<C-U>call sneak#wrap(visualmode(), 3, 0, 2, 1)<CR>
" xnoremap <silent> S :<C-U>call sneak#wrap(visualmode(), 3, 1, 2, 1)<CR>
" onoremap <silent> s :<C-U>call sneak#wrap(v:operator,   3, 0, 2, 1)<CR>
" onoremap <silent> S :<C-U>call sneak#wrap(v:operator,   3, 1, 2, 1)<CR>
