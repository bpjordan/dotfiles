# vim: ft=zsh

# git integration
autoload -Uz vcs_info
precmd() { vcs_info }

zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:git:*' formats '%b %m%u%c'

PROMPT='%F{magenta}%n'
if [[ -v WSL_DISTRO_NAME ]]; then
    PROMPT+="@${WSL_DISTRO_NAME}[WSL]"
elif [[ -v SSH_CLIENT ]]; then
    PROMPT+="@%2m[SSH]"
else
    PROMPT+="@%M"
fi

PROMPT+='%F{reset}:%F{red}%4~ %B%F{cyan}%# %b%F{reset}'

RPROMPT='%(?.%F{green}✓%F{reset}. %? %F{red}%B⨯%b%F{reset})%(1j. %j %F{yellow}%B⚙%b%F{reset}.) ${vcs_info_msg_0_}'
