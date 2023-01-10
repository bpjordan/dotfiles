

call plug#begin()

Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase'}

call plug#end()

let g:Hexokinase_highlighters = [ 'background' ]
