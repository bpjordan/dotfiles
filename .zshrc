local ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

if [ ! -d "$ZINIT_HOME" ]; then
  mkdir -p "$(dirname $ZINIT_HOME)"
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

source "${ZINIT_HOME}/zinit.zsh"

zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions

autoload -U compinit && compinit

bindkey -e

HISTSIZE=5000
SAVEHIST=$HISTSIZE
HISTDUP=erase

setopt appendhistory sharehistory
setopt hist_ignore_space hist_ignore_all_dups hist_save_no_dups
setopt hist_ignore_dups hist_find_no_dups

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

alias ls='ls --color'

#####################
#
# Git Integration
#
#####################

autoload -Uz vcs_info

zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:git:*' actionformats '%u%c%m %F{cyan}%b(%B%a%%b)%F{reset}'
zstyle ':vcs_info:git:*' formats '%u%c%m%F{yellow} %F{cyan}%b%F{reset}'
zstyle ':vcs_info:git:*' stagedstr '%F{green}●%F{reset} '
zstyle ':vcs_info:git:*' unstagedstr '%F{red}●%F{reset} '

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
  (( $to_push_pull[1] )) && gitstatus+=( "%B%F{blue}↑%F{reset}%b" )
  (( $to_push_pull[2] )) && gitstatus+=( "%B%F{blue}↓%F{reset}%b" )

    # adds to %m
    hook_com[misc]=''
    [[ ! -z $gitstatus ]] && hook_com[misc]+="${(j:/:)gitstatus} "

    ### show remote branch if it is different from local branch
    local remote=${$(git rev-parse --verify ${hook_com[branch]}@{upstream} \
      --symbolic-full-name 2>/dev/null)/refs\/remotes\/}

    if [[ -n ${remote} && ${remote#*/} != ${hook_com[branch]} ]] ; then
      # adds remote information to %b
      hook_com[branch]="${hook_com[branch]}[${remote}]"
    fi
  }

  precmd() { vcs_info }

### Refresh prompt
# refresh prompt every TMOUT seconds
TMOUT=1
TRAPALRM() {
  case "$WIDGET" in
    expand-or-complete|self-insert|up-line-or-beginning-search|down-line-or-beginning-search|backward-delete-char|.history-incremental-search-backward|.history-incremental-search-forward)
      :
      ;;

    *)
      vcs_info
      zle reset-prompt
      ;;
  esac
}


###########
#
# PROMPT
#
###########

setopt prompt_subst

prompt_pwd () {
  # https://stackoverflow.com/a/73590795
  local p=${${PWD:/~/\~}/#~\//\~/}
  print "${(@j[/]M)${(@s[/]M)p##*/}##(.|)?}$p:t"
}

# build prompt
PROMPT=''
if [[ -v WSL_DISTRO_NAME ]]; then
  PROMPT+="%F{magenta}${WSL_DISTRO_NAME}[WSL]%F{reset}:"
elif [[ -v SSH_CLIENT ]]; then
  PROMPT+="%F{magenta}%n@%m[SSH]%F{reset}:"
fi

# PROMPT+='%F{reset}:%F{red}$(shrink_path -f) %B%F{cyan}%# %b%F{reset}'
PROMPT+='%F{red}$(prompt_pwd) %B%F{cyan}%# %b%f'

RPROMPT='${vcs_info_msg_0_} %(?.%F{green}✓%F{reset}.%? %F{red}%B⨯%b%F{reset})%(1j. %j%F{yellow}%B⚙%b%F{reset}.)'

#######################
#
# PEFERENCES
#
#######################

export EDITOR=vim
export GO111MODULE=on

if [ -f ~/.bash_shortcuts ]; then
  . ~/.bash_shortcuts
fi

if [ -d "$HOME/.dotfiles/scripts" ]; then
  export PATH="$HOME/.dotfiles/scripts:$PATH"
  alias s=tmux-sessionizer
fi

[ -f "$HOME/.cargo/env " ] && . "$HOME/.cargo/env"

if [ -d "$HOME/go/bin" ]; then
  export GOROOT=/usr/local/go
  export GOPATH=$HOME/go
  export PATH="$GOPATH/bin:$GOROOT/bin:$PATH"
fi

# if [[ ! ( -v SSH_CLIENT ) && ( "${TERM_PROGRAM}" == "WezTerm" ) ]] && infocmp wezterm &> /dev/null; then
#   export TERM=wezterm
# fi
#
case $TERM in
  alacritty ) export COLORTERM=truecolor ;;
esac

export PATH="$HOME/.local/bin:$PATH"

export BAT_PAGER="less -F"

tf_bin=$(command -v terraform)
if [[ -n "$tf_bin" ]]; then
  autoload -U +X bashcompinit && bashcompinit
  complete -o nospace -C "$tf_bin" terraform
  alias tf=terraform
fi
