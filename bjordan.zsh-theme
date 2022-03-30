PROMPT="%(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ )"
PROMPT+=' %{$fg[cyan]%}%c%{$reset_color%} $(git_prompt_info)'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}✗"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"

PROMPT="%F{magenta}%n@%M%F{reset}:%F{red}%4~ %B%F{cyan}%(!.#.$) %b%F{reset}"

PROMPT='%F{magenta}%n'
if [[ -v WSL_DISTRO_NAME ]]; then
    PROMPT+="@${WSL_DISTRO_NAME}[WSL]"
elif [[ -v SSH_CLIENT ]]; then
    PROMPT+="@%M[SSH]"
else
    PROMPT+="@%M"
fi

PROMPT+='%F{reset}:%F{red}%4~ %B%F{cyan}%# %b%F{reset}'

RPROMPT='%(?.%F{green}✓%F{reset}. %? %F{red}%B⨯%b%F{reset})%(1j. %j %F{yellow}%B⚙%b%F{reset}.) %t'
