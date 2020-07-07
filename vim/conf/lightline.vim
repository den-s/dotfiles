let g:lightline = {
      \ 'colorscheme': 'gotham',
      \  'active': {
      \    'left': [ [ 'mode', 'paste' ],
      \              [ 'fugitive', 'githunks', 'gitversion' ],
      \              [ 'filename', 'ctrlpmark' ] ],
      \    'right': [ [ 'ale' ], [ 'percent', 'lineinfo' ],
      \               [ 'filetype' ] ]
      \ },
      \  'inactive': {
      \    'left': [ ['mode'], [ 'fugitive' ], [ 'filename' ] ],
      \    'right': [],
      \ },
      \  'tab': {
      \   'active': [ 'tabnum', 'filename', 'modified' ],
      \   'inactive': [ 'tabnum', 'filename', 'modified' ] },
      \ 'component': {
      \  'lineinfo': ' %2l:%-2v',
      \  'percent': '%2p%%',
      \ },
      \ 'component_function': {
      \  'fugitive': 'LightlineFugitive',
      \  'githunks': 'LightlineHunks',
      \  'gitversion': 'LightLineGitversion',
      \  'ctrlpmark': 'CtrlPMark',
      \  'mode': 'LightlineMode',
      \  'filename': 'LightlineFilename',
      \  'ale': 'LightlineAle',
      \  'modified': 'LightlineModified',
      \  'filetype': 'LightlineFiletype',
      \ },
      \  'separator': { 'left': '', 'right': '' },
      \  'subseparator': { 'left': '', 'right': '' },
      \  'tabline_separator': { 'left': '', 'right': '' },
      \  'tabline_subseparator': { 'left': '', 'right': '' }
      \ }

" \  'fileencoding': 'LightlineFileencoding',
" \  'fileformat': 'LightlineFileformat',
" \  'filetype': 'LightlineFiletype',
" \  'subseparator': { 'left': '', 'right': '' },
let g:lightline.mode_map = {
      \ 'n' : 'N',
      \ 'i' : 'I',
      \ 'R' : 'R',
      \ 'v' : 'V',
      \ 'V' : 'V-LINE',
      \ "\<C-v>": 'V-BLOCK',
      \ 'c' : 'S',
      \ 's' : 'S',
      \ 'S' : 'S-LINE',
      \ "\<C-s>": 'S-BLOCK',
      \ 't': 'T',
      \ }

let g:lightline.tabline = {
      \ 'left': [ [ 'tabs' ] ],
      \ 'right': [] }

function! LightlineReadonly()
  return &readonly ? '' : ''
endfunction

function! LightlineFugitive()
  if exists('*FugitiveHead')
    let branch = FugitiveHead()
    return branch !=# '' && winwidth(0) > 60 ? ' '.branch : ''
  endif
  return ''
endfunction


function! LightLineGitversion()
  let fullname = expand('%')
  let gitversion = ''
  if fullname =~? 'fugitive://.*/\.git//0/.*'
    let gitversion = 'git index'
  elseif fullname =~? 'fugitive://.*/\.git//2/.*'
    let gitversion = 'git target'
  elseif fullname =~? 'fugitive://.*/\.git//3/.*'
    let gitversion = 'git merge'
  elseif &diff == 1
    let gitversion = 'working copy'
  endif
  return gitversion
endfunction

function! CtrlPMark()
  if expand('%:t') =~ 'ControlP' && has_key(g:lightline, 'ctrlp_item')
    call lightline#link('iR'[g:lightline.ctrlp_regex])
    return lightline#concatenate([g:lightline.ctrlp_prev, g:lightline.ctrlp_item
          \ , g:lightline.ctrlp_next], 0)
  else
    return ''
  endif
endfunction

let g:ctrlp_status_func = {
      \ 'main': 'CtrlPStatusFunc_1',
      \ 'prog': 'CtrlPStatusFunc_2',
      \ }

function! LightlineMode()
  let fname = expand('%:t')
  return fname == '__Tagbar__' ? 'Tagbar' :
        \ fname == 'ControlP' ? 'CtrlP' :
        \ fname == '__Gundo__' ? 'Gundo' :
        \ fname == '__Gundo_Preview__' ? 'Gundo Preview' :
        \ fname =~ 'NERD_tree' ? 'NERDTree' :
        \ fname =~ 'defx' ? 'Defx' :
        \ &ft == 'unite' ? 'Unite' :
        \ &ft == 'vimfiler' ? 'VimFiler' :
        \ &ft == 'vimshell' ? 'VimShell' :
        \ winwidth(0) > 60 ? lightline#mode() : ''
endfunction

function! CtrlPStatusFunc_1(focus, byfname, regex, prev, item, next, marked)
  let g:lightline.ctrlp_regex = a:regex
  let g:lightline.ctrlp_prev = a:prev
  let g:lightline.ctrlp_item = a:item
  let g:lightline.ctrlp_next = a:next
  return lightline#statusline(0)
endfunction

function! CtrlPStatusFunc_2(str)
  return lightline#statusline(0)
endfunction

function! LightlineFileformat()
  return winwidth(0) > 120 ? &fileformat : ''
endfunction

function! LightlineFiletype()
  return winwidth(0) > 70 ? (&filetype !=# '' ? &filetype : 'no ft') : ''
endfunction

" function! LightlineFileencoding()
"   return winwidth(0) > 120 ? (&fenc !=# '' ? &fenc : &enc) : ''
" endfunction

function! LightlineModified()
  return winwidth(0) > 70 ? (&modified > 0 ? '[+]' : '') : ''
endfunction

function! LightlineAle()
  let counts = ale#statusline#Count(bufnr(''))
  let errors = counts.error > 0 ? 'E:'.counts.error : ''
  let warnings = counts.warning > 0 ? (errors !=# '' ? ' W:'.counts.warning : 'W:'.counts.warning) : ''
  return errors.warnings
endfunction

function! LightlineFilename()
  let fname = expand('%:t')
  return fname == 'ControlP' && has_key(g:lightline, 'ctrlp_item') ? g:lightline.ctrlp_item :
        \ fname ==# '__Tagbar__' ? g:lightline.fname :
        \ fname ==# '__Gundo__' ? 'Gundo' :
        \ fname ==# '__Gundo_Preview__' ? 'Gundo Preview' :
        \ fname =~# 'NERD_tree' ? '' :
        \ fname =~# 'defx' ? '' :
        \ &ft == 'vimfiler' ? vimfiler#get_status_string() :
        \ &ft == 'unite' ? unite#get_status_string() :
        \ &ft == 'vimshell' ? vimshell#get_status_string() :
        \ ('' != LightlineReadonly() ? LightlineReadonly() . ' ' : '') .
        \ ('' != fname ? (winwidth(0) > 120 ? expand('%') : expand('%:t')) : '[No Name]') .
        \ ('' != LightlineModified() ? ' ' . LightlineModified() : '')
endfunction

function! LightlineHunks()
  let symbols = ['+', '-', '~']
  let [added, modified, removed] = sy#repo#get_stats()
  let stats = [added, removed, modified]  " reorder
  let hunkline = ''

  if stats != [-1, -1, -1]
    for i in range(3)
      let hunkline .= printf('%s%s ', symbols[i], stats[i])
    endfor
    return winwidth(0) > 70 ? (hunkline) : ''
  endif

  return ''
endfunction

let g:unite_force_overwrite_statusline = 0
let g:vimfiler_force_overwrite_statusline = 0
let g:vimshell_force_overwrite_statusline = 0
