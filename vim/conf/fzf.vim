" let g:fzf_colors =
" \ { 'fg':      ['fg', 'Normal'],
  " \ 'bg':      ['bg', 'Normal'],
  " \ 'hl':      ['fg', 'Comment'],
  " \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  " \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  " \ 'hl+':     ['fg', 'Statement'],
  " \ 'info':    ['fg', 'PreProc'],
  " \ 'border':  ['fg', 'Ignore'],
  " \ 'prompt':  ['fg', 'Conditional'],
  " \ 'pointer': ['fg', 'Exception'],
  " \ 'marker':  ['fg', 'Keyword'],
  " \ 'spinner': ['fg', 'Label'],
  " \ 'header':  ['fg', 'Comment'] }

let g:fzf_buffers_jump = 1

let $FZF_DEFAULT_OPTS = '--bind up:preview-up,down:preview-down'

nmap ; :Files<cr>
nmap <leader>fb :Buffers<CR>
nmap <leader>fg :GFiles<CR>
nmap <leader>fgs :GFiles?<CR>

let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'

function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case -- %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)

" set rtp+=/usr/local/opt/fzf
