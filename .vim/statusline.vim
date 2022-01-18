


function! GitBranch()
    return system("git -C '".expand('%:p:h')."' rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
endfunction

function! StatusLineGit()
    let l:branchname = GitBranch()
    return strlen(l:branchname) > 0?' git:'.l:branchname.' ':''
endfunction

augroup updategitinfo
    au!
    autocmd BufEnter,FocusGained,BufWritePost * let b:gitinfo = StatusLineGit()
augroup end

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
    autocmd WinLeave * silent call setwinvar(winnr(), 'curr', 0)
    autocmd WinEnter * silent call setwinvar(winnr(), 'curr', 1)
augroup END
call setwinvar(winnr(), 'curr', 1)

set noshowmode

"Actually building the thing starts here
set laststatus=2
set statusline=
set statusline+=%#ModeBlockColor#
set statusline+=%{IsCurrentWindow()?'\ \ \ '.StatusLineMode(mode()).'\ \ ':''}
set statusline+=%#StatusLine#
set statusline+=\ %f%m%r%w
set statusline+=\ %{get(b:,'gitinfo','')}
set statusline+=%=
set statusline+=%y
set statusline+=\ col:%c
set statusline+=\ %l/%L
