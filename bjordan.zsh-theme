# vim: ft=zsh

### Git Integration

autoload -Uz vcs_info
precmd() { vcs_info }

zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:git:*' formats '%b %u%c%m'

## Hook for showing information about the git remote
zstyle ':vcs_info:git*+set-message:*' hooks git-remoteinfo

function +vi-git-remoteinfo() {
    ### exit early if not in a remote tracking branch
    if ! git rev-parse ${hook_com[branch]}@{upstream} >/dev/null 2>&1; then
        hook_com[branch]="${hook_com[branch]}[*]"
        return 0
    fi

    ### show changes to push/pull from remote
    local -a to_push_pull=(
        $( git rev-list \
            --left-right \
            --count HEAD...${hook_com[branch]}@{upstream} \
            2>/dev/null
        )
    )

    local -a gitstatus
    (( $to_push_pull[1] )) && gitstatus+=( "↑")
    (( $to_push_pull[2] )) && gitstatus+=( "↓")

    # adds to %m
    hook_com[misc]+=${(j:/:)gitstatus}

    ### show remote branch if it is different from local branch
    local remote=${$(git rev-parse --verify ${hook_com[branch]}@{upstream} \
        --symbolic-full-name 2>/dev/null)/refs\/remotes\/}

    if [[ -n ${remote} && ${remote#*/} != ${hook_com[branch]} ]] ; then
        # adds remote information to %b
        hook_com[branch]="${hook_com[branch]}[${remote}]"
    fi
}

# build prompt
PROMPT=''
if [[ -v WSL_DISTRO_NAME ]]; then
    PROMPT+="${WSL_DISTRO_NAME}[WSL]%F{reset}:"
elif [[ -v SSH_CLIENT ]]; then
    PROMPT+="%F{magenta}%n@%2m[SSH]%F{reset}:"
fi

# PROMPT+='%F{reset}:%F{red}$(shrink_path -f) %B%F{cyan}%# %b%F{reset}'
PROMPT+='%F{red}$(shrink_path -f) %B%F{cyan}%# %b%f'

RPROMPT='%(?.%F{green}✓%F{reset}. %? %F{red}%B⨯%b%F{reset})%(1j. %j%F{yellow}%B⚙%b%F{reset}.) ${vcs_info_msg_0_}'
