ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

if [ ! -d "$ZINIT_HOME" ]; then
    mkdir -p "$(dirname $ZINIT_HOME)"
    git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

source "${ZINIT_HOME}/zinit.zsh"

zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions

autoload -U compinit && compinit

HISTSIZE=5000
SAVEHIST=$HISTSIZE
HISTDUP=erase

bindkey -e

setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

alias ls='ls --color'

### Git Integration

autoload -Uz vcs_info

zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:git:*' actionformats '%u%c%m%F{cyan}%b(%B%a%%b)%F{reset}'
zstyle ':vcs_info:git:*' formats '%u%c%m%F{cyan}%b%F{reset}'
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

# build prompt
PROMPT=''
if [[ -v WSL_DISTRO_NAME ]]; then
    PROMPT+="%F{magenta}${WSL_DISTRO_NAME}[WSL]%F{reset}:"
elif [[ -v SSH_CLIENT ]]; then
    PROMPT+="%F{magenta}%n@%m[SSH]%F{reset}:"
fi

# PROMPT+='%F{reset}:%F{red}$(shrink_path -f) %B%F{cyan}%# %b%F{reset}'
PROMPT+='%F{red}$(shrink_path -f) %B%F{cyan}%# %b%f'

RPROMPT='${vcs_info_msg_0_} %(?.%F{green}✓%F{reset}.%? %F{red}%B⨯%b%F{reset})%(1j. %j%F{yellow}%B⚙%b%F{reset}.)'

########
#
# OMZ
#
########

# # If you come from bash you might have to change your $PATH.
# # export PATH=$HOME/bin:/usr/local/bin:$PATH
#
# # Path to your oh-my-zsh installation.
# export ZSH="$HOME/.oh-my-zsh"
#
# # Set name of the theme to load --- if set to "random", it will
# # load a random theme each time oh-my-zsh is loaded, in which case,
# # to know which specific one was loaded, run: echo $RANDOM_THEME
# # See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# ZSH_THEME="bjordan" # set by `omz`
#
# # Set list of themes to pick from when loading at random
# # Setting this variable when ZSH_THEME=random will cause zsh to load
# # a theme from this variable instead of looking in $ZSH/themes/
# # If set to an empty array, this variable will have no effect.
# # ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )
#
# # Uncomment the following line to use case-sensitive completion.
# # CASE_SENSITIVE="true"
#
# # Uncomment the following line to use hyphen-insensitive completion.
# # Case-sensitive completion must be off. _ and - will be interchangeable.
# # HYPHEN_INSENSITIVE="true"
#
# # Uncomment one of the following lines to change the auto-update behavior
# # zstyle ':omz:update' mode disabled  # disable automatic updates
# # zstyle ':omz:update' mode auto      # update automatically without asking
# # zstyle ':omz:update' mode reminder  # just remind me to update when it's time
#
# # Uncomment the following line to change how often to auto-update (in days).
# # zstyle ':omz:update' frequency 13
#
# # Uncomment the following line if pasting URLs and other text is messed up.
# # DISABLE_MAGIC_FUNCTIONS="true"
#
# # Uncomment the following line to disable colors in ls.
# # DISABLE_LS_COLORS="true"
#
# # Uncomment the following line to disable auto-setting terminal title.
# # DISABLE_AUTO_TITLE="true"
#
# # Uncomment the following line to enable command auto-correction.
# # ENABLE_CORRECTION="true"
#
# # Uncomment the following line to display red dots whilst waiting for completion.
# # You can also set it to another string to have that shown instead of the default red dots.
# # e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# # Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# # COMPLETION_WAITING_DOTS="true"
#
# # Uncomment the following line if you want to disable marking untracked files
# # under VCS as dirty. This makes repository status check for large repositories
# # much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"
#
# # Uncomment the following line if you want to change the command execution time
# # stamp shown in the history command output.
# # You can set one of the optional three formats:
# # "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# # or set a custom format using the strftime function format specifications,
# # see 'man strftime' for details.
# # HIST_STAMPS="mm/dd/yyyy"
#
# # Would you like to use another custom folder than $ZSH/custom?
# # ZSH_CUSTOM=/path/to/new-custom-folder
#
# # Which plugins would you like to load?
# # Standard plugins can be found in $ZSH/plugins/
# # Custom plugins may be added to $ZSH_CUSTOM/plugins/
# # Example format: plugins=(rails git textmate ruby lighthouse)
# # Add wisely, as too many plugins slow down shell startup.
# plugins=(zsh-autosuggestions zsh-syntax-highlighting shrink-path sudo gitfast git-auto-fetch)
# ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)
#
# source $ZSH/oh-my-zsh.sh
#
# # User configuration
#
# # export MANPATH="/usr/local/man:$MANPATH"
#
# # You may need to manually set your language environment
# # export LANG=en_US.UTF-8
#
# # Preferred editor for local and remote sessions
# # if [[ -n $SSH_CONNECTION ]]; then
# #   export EDITOR='vim'
# # else
# #   export EDITOR='mvim'
# # fi
#
# # Compilation flags
# # export ARCHFLAGS="-arch x86_64"
#
# # Set personal aliases, overriding those provided by oh-my-zsh libs,
# # plugins, and themes. Aliases can be placed here, though oh-my-zsh
# # users are encouraged to define aliases within the ZSH_CUSTOM folder.
# # For a full list of active aliases, run `alias`.
# #
# # Example aliases
# # alias zshconfig="mate ~/.zshrc"
# # alias ohmyzsh="mate ~/.oh-my-zsh"
# #

export EDITOR=vim
export GO111MODULE=on

if [ -f ~/.bash_shortcuts ]; then
    . ~/.bash_shortcuts
fi

if [ -d "$HOME/.dotfiles/scripts" ]; then
    export PATH="$HOME/.dotfiles/scripts:$PATH"
    alias s=tmux-sessionizer
fi

if [ -f "$HOME/.cargo/env " ]; then
    . "$HOME/.cargo/env"
fi

if [ -d "$HOME/go/bin" ]; then
    export GOROOT=/usr/local/go
    export GOPATH=$HOME/go
    export PATH="$GOPATH/bin:$GOROOT/bin:$PATH"
fi

if [[ ! ( -v SSH_CLIENT ) && ( "${TERM_PROGRAM}" == "WezTerm" ) ]] && infocmp wezterm &> /dev/null; then
    export TERM=wezterm
fi

case $TERM in
    alacritty ) export COLORTERM=truecolor ;;
esac

export PATH="$HOME/.local/bin:$PATH"

export BAT_PAGER="less -F"

export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
#
