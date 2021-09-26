command Py w|!python3 %:.
command Upload w|!arduino-cli.exe compile -u
command Compile w|!g++ -o %:.:r %:. && ./%:.:r

autocmd BufNewFile *.cpp 0r ~/.vim/templates/cxxSkeleton.cxx
autocmd BufNewFile *.cxx 0r ~/.vim/templates/cxxSkeleton.cxx

set autoindent
set tabstop=4
set list listchars=tab:\ \ ,trail:·
