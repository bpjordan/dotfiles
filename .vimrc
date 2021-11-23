

"Statusline
function! GitBranch()
    return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
endfunction

function! StatusLineGit()
    let l:branchname = GitBranch()
    return strlen(l:branchname) > 0?'  '.l:branchname.' ':''
endfunction

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
inoremap {<CR> <CR>{<CR>}<Up><CR><Tab>
inoremap ( ()<Left>
inoremap { {}<Left>
inoremap [ []<Left>

inoremap <expr> ) strpart(getline('.'), col('.')-1, 1) == ')' ? '<Right>' : ')'
inoremap <expr> } strpart(getline('.'), col('.')-1, 1) == '}' ? '<Right>' : '}'
inoremap <expr> ] strpart(getline('.'), col('.')-1, 1) == ']' ? '<Right>' : ']'
inoremap <expr> " strpart(getline('.'), col('.')-1, 1) == '"' ? '<Right>' : '""<Left>'
inoremap <expr> ' strpart(getline('.'), col('.')-1, 1) == "'" ? '<Right>' : "''<Left>"

"Settings related to whitespace
set autoindent
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set list listchars=trail:·,tab:»·
set scrolloff=7

autocmd FileType make set noexpandtab

"Setting related to split views
set splitright
set splitbelow

nnoremap <C-J> <C-W><C-J>
nnoremap <C-H> <C-W><C-H>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
