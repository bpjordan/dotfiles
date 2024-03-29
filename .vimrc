
"Build statusline
so ~/.vim/statusline.vim

"Handle Plugins
so ~/.vim/plugins.vim

"Build Theme
so ~/.vim/colors.vim

"Commands for quickly testing programs and scripts
command Py w|!python3 %:.
command Upload w|!arduino-cli.exe compile -u
command Gcc w|!g++ -o %:.:r %:. && ./%:.:r
command Java w|!javac.exe % && java.exe %:r

"Boilerplate skeletons
function! NewJava()
    silent! 0r ~/.vim/templates/skeleton.java
    2s/SKELETON/\=expand("%:t:r")/g
    8s/START//g
endfunction

autocmd BufNewFile *.cpp 0r ~/.vim/templates/cxxSkeleton.cxx
autocmd BufNewFile *.cxx 0r ~/.vim/templates/cxxSkeleton.cxx
autocmd BufNewFile *.c 0r ~/.vim/templates/skeleton.c
autocmd BufNewFile Makefile 0r ~/.vim/templates/makeSkeleton.txt
autocmd BufNewFile *.java call NewJava()

"Autocompletion/closing of brackets, quotes, etc
inoremap {<CR> {<CR>}<Up><END><CR>
inoremap ( ()<Left>
inoremap { {}<Left>
inoremap [ []<Left>

inoremap <expr> ) strpart(getline('.'), col('.')-1, 1) == ')' ? '<Right>' : ')'
inoremap <expr> } strpart(getline('.'), col('.')-1, 1) == '}' ? '<Right>' : '}'
inoremap <expr> ] strpart(getline('.'), col('.')-1, 1) == ']' ? '<Right>' : ']'
inoremap <expr> " strpart(getline('.'), col('.')-1, 1) == '"' ? '<Right>' : '""<Left>'
inoremap <expr> ' strpart(getline('.'), col('.')-1, 1) == "'" ? '<Right>' : "''<Left>"

"Relative numberlines
set number

augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
augroup END

"Settings related to whitespace
set autoindent
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set list listchars=trail:·,tab:»·
set scrolloff=7
set modeline

autocmd FileType make set noexpandtab
autocmd FileType yaml set tabstop=2 shiftwidth=2 softtabstop=2

"Setting related to split views
set splitright
set splitbelow

"Highlight matches as search is typed
set incsearch

"Enable mouse
set mouse=a

if $TERM == 'alacritty'
    set ttymouse=sgr
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif

nnoremap <C-J> <C-W><C-J>
nnoremap <C-H> <C-W><C-H>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>

set clipboard=unnamedplus
set hlsearch
set ignorecase
set noswapfile
set undofile
set nowrap
