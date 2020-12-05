" Function: display errors from Ale in statusline
function! LinterStatus() abort
   let l:counts = ale#statusline#Count(bufnr(''))
   let l:all_errors = l:counts.error + l:counts.style_error
   let l:all_non_errors = l:counts.total - l:all_errors
   return l:counts.total == 0 ? '' : printf(
   \ 'W:%d E:%d',
   \ l:all_non_errors,
   \ l:all_errors
   \)
endfunction

" Dictionary: take mode() input -> longer notation of current mode
" mode() is defined by Vim
let g:currentmode={ 'n' : 'N', 'no' : 'N·Operator Pending ', 'v' : 'V', 'V' : 'V·Line ', '^V' : 'V·Block ', 's' : 'S', 'S': 'S·Line ', '^S' : 'S·Block ', 'i' : 'I', 'R' : 'R', 'Rv' : 'V·Replace ', 'c' : 'C', 'cv' : 'Vim Ex ', 'ce' : 'Ex ', 'r' : 'P', 'rm' : 'More ', 'r?' : 'C', '!' : 'Sh', 't' : 'T'}


" Function: return current mode
" abort -> function will abort soon as error detected
function! ModeCurrent() abort
    let l:modecurrent = mode()
    " use get() -> fails safely, since ^V doesn't seem to register
    " 3rd arg is used when return of mode() == 0, which is case with ^V
    " thus, ^V fails -> returns 0 -> replaced with 'V Block'
    let l:modelist = toupper(get(g:currentmode, l:modecurrent, 'V·Block '))
    let l:current_status_mode = l:modelist
    return l:current_status_mode
endfunction

function! FileSize() abort
    let l:bytes = getfsize(expand('%p'))
    if (l:bytes >= 1024)
        let l:kbytes = l:bytes / 1025
    endif
    if (exists('kbytes') && l:kbytes >= 1000)
        let l:mbytes = l:kbytes / 1000
    endif

    if l:bytes <= 0
        return '0'
    endif

    if (exists('mbytes'))
        return l:mbytes . 'MB '
    elseif (exists('kbytes'))
        return l:kbytes . 'KB '
    else
        return l:bytes . 'B '
    endif
endfunction

function! ReadOnly() abort
  if &readonly || !&modifiable
    return ''
  else
    return ''
endfunction

set laststatus=2
set statusline=
set statusline+=\ %{ModeCurrent()}
set statusline+=\ %*
set statusline+=\ ‹‹
set statusline+=\ %f\ %*
set statusline+=\ ››
set statusline+=\ %m
set statusline+=%=
set statusline+=\ %{LinterStatus()}
set statusline+=\ ‹‹
set statusline+=\ %{strftime('%R', getftime(expand('%')))}
set statusline+=\ :
set statusline+=\ %l
set statusline+=\ ::
set statusline+=\ %n
set statusline+=\ ››\ %*

set statusline+=\ %{(&fenc!=''?&fenc:&enc)}
" current time, when buffer saved
set statusline+=\ %{strftime('%R', getftime(expand('%')))}
set statusline+=\ %{&fileformat}
