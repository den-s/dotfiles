function! s:goyo_enter()
  set nofoldenable
  set noshowmode
  set noshowcmd
  set scrolloff=999
  let &showbreak = ' '
  set listchars=tab:▸·,extends:…,precedes:«,extends:»,trail:·
endfunction

function! s:goyo_leave()
  set foldenable
  set showmode
  set showcmd
  set scrolloff=5
  let &showbreak = '↳ '
  set listchars=tab:▸·,extends:…,precedes:«,extends:»,trail:·,eol:¬
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()

nmap <leader>gg :Goyo<cr>
