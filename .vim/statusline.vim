


function! GitBranch()
    return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
endfunction

function! StatusLineGit()
    let l:branchname = GitBranch()
    return strlen(l:branchname) > 0?' Git: '.l:branchname.' ':''
endfunction

function! StatusLineMode(mode)
    let l:modeReadable={
        \ 'n'  : 'NORMAL',
        \ 'no' : 'NORMAL·OP',
        \ 'v'  : 'VISUAL',
        \ 'V'  : 'V·LINE',
        \ '\<C-V>' : 'V·BLOCK',
        \ 's'  : 'SELECT',
        \ 'S'  : 'S·LINE',
        \ '\<C-S>' : 'S·BLOCK',
        \ 'i'  : 'INSERT',
        \ 'R'  : 'REPLACE',
        \ 'Rv' : 'V·REPLACE',
        \ 'c'  : 'COMMAND',
        \ 'cv' : 'VIM EX',
        \ 'ce' : 'EX',
        \ 'r'  : 'PROMPT',
        \ 'rm' : 'MORE',
        \ 'r?' : 'CONFIRM',
        \ '!'  : 'SHELL',
        \ 't'  : 'TERMINAL'
        \}

    if a:mode == 'i'
        hi ModeBlockColor ctermbg=magenta
    elseif tolower(a:mode) == 'v'
        hi ModeBlockColor ctermbg=1
    elseif a:mode == 'n'
        hi ModeBlockColor ctermbg=39
    else
        hi ModeBlockColor ctermbg=1
    endif


    return l:modeReadable[mode()]
endfunction

function! IsCurrentWindow()
    return getwinvar(winnr(), 'curr')
endfunction

augroup TrackCurrentWindow
    autocmd!
    autocmd WinLeave * call setwinvar(winnr(), 'curr', 0)
    autocmd WinEnter * call setwinvar(winnr(), 'curr', 1)
augroup END

"Color Settings
":so $VIMRUNTIME/syntax/hitest.vim
hi ModeBlockColor cterm=none
hi StatusLine cterm=none ctermbg=238

set laststatus=2
set statusline=
set statusline+=%#ModeBlockColor#
set statusline+=%{IsCurrentWindow()?'\ \ \ '.StatusLineMode(mode()).'\ \ ':''}
set statusline+=%#StatusLine#
set statusline+=\ %f
set statusline+=\ \ %{StatusLineGit()}
set statusline+=%=
set statusline+=%y
set statusline+=\ %l:%L
