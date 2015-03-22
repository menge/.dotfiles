colorscheme desert256
syntax on

set autoindent
set smartindent

set expandtab
set shiftwidth=3
set softtabstop=3

set diffopt+=iwhite

set foldmethod=syntax
let g:xml_syntax_folding=1
let g:perl_fold=1
let g:perl_fold_blocks=1

syntax enable

map <F12> mpi<strike><ESC>A</strike> -- <emeng @ <ESC>:r! date<CR>kJA><ESC>`p
nmap <C-\> :tnext<CR>
nmap ,, :qa<CR>

filetype plugin on

let &titlestring = "[" . expand("%:t") . "]"
let &titleold = "$SHELL"
"if &term == "screen" || &term == "screen-256color"
"    set t_ts=k
"    set t_fs=\
"endif
"if &term == "screen" || &term == "screen-256color"
"    set title
"endif
