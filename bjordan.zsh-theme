# vim: ft=zsh

# git integration
autoload -Uz vcs_info
precmd() { vcs_info }

zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:git:*' formats '%b %m%u%c'

# build prompt
PROMPT=''
if [[ -v WSL_DISTRO_NAME ]]; then
    PROMPT+="${WSL_DISTRO_NAME}[WSL]%F{reset}:"
elif [[ -v SSH_CLIENT ]]; then
    PROMPT+="%F{magenta}%n@%2m[SSH]%F{reset}:"
fi

# PROMPT+='%F{reset}:%F{red}$(shrink_path -f) %B%F{cyan}%# %b%F{reset}'
PROMPT+='%F{red}$(shrink_path -f) %B%F{cyan}%# %b%F{reset}'

RPROMPT='%(?.%F{green}✓%F{reset}. %? %F{red}%B⨯%b%F{reset})%(1j. %j %F{yellow}%B⚙%b%F{reset}.) ${vcs_info_msg_0_}'
