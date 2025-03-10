set tabstop=4
set softtabstop=4
set shiftwidth=4
set textwidth=119
set expandtab
set autoindent
set foldmethod=indent
set colorcolumn=120

let NERDSpaceDelims = 0

let cch = synIDattr(synIDtrans(hlID("ColorColumn")), "bg#")

" highlight OverLength ctermbg=cch ctermfg=white guibg=cch
match ColorColumn /\%121v.\+/
