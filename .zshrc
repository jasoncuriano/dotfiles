# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Autocompletions
autoload -U compinit && compinit

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Add Homebrew and Homebrew's installed binaries to your $PATH
export PATH="/opt/homebrew/sbin:/opt/homebrew/bin:$PATH"

# Go Path Environment Variable
export PATH="$HOME/go/bin:$PATH"

# n Version Manager for Node
export PATH="$HOME/.n/bin:$PATH"

# Terraform binary path for tfswitch
export PATH="$HOME/.tfswitch/bin:$PATH"

# Path for Poetry
export PATH="$HOME/.poetry/bin:$PATH"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"
# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
export DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
HIST_STAMPS="yyyy-mm-dd"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.

plugins=(colored-man-pages colorize python brew)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
export LANG="en_US.UTF-8"

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
    export EDITOR='vim'
else
    export EDITOR='vim'
fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

## Node
export N_PREFIX=$HOME/.n
export PATH=$N_PREFIX/bin:$PATH
alias ni="npm install"
alias nrs="npm run-script"

## Python
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"    # if `pyenv` is not already on PATH
eval "$(pyenv init --path)"
eval "$(pyenv init -)"
# Avoid Homebrew formulae from accidentally linking against a Pyenv-provided Python
alias brew='env PATH="${PATH//$(pyenv root)\/shims:/}" brew'
alias python='python3'
alias py='python'

## Terraform
alias tf='terraform'

## k8s
alias k='kubectl'
# kubectl autocomplete
[[ /opt/homebrew/bin/kubectl ]] && source <(kubectl completion zsh)
#kube-ps1
export KUBE_PS1_SYMBOL_ENABLE="false"
export KUBE_PS1_SYMBOL_USE_IMG="false"
export KUBE_PS1_CTX_COLOR="yellow"
source "/opt/homebrew/opt/kube-ps1/share/kube-ps1.sh"
PS1='$(kube_ps1)'$PS1

alias wtfismyip='curl -s https://wtfismyip.com/json | jq -r'

# Antigen ZSH Plugins
source $HOME/.antigen.zsh
antigen init $HOME/.antigenrc

# Git Aliases
alias gs="git status"
alias gg="git grep -n"
alias gd="git diff"
alias gdc="git diff --cached"
alias gcv="git commit -v"
alias gca="git commit --amend -v"
alias gap="git add -p"
alias gac="git add -all .; git commit -v"
alias glp="git log -p"
alias gch="git checkout"
alias gcb="git checkout -b"
alias gush="git push origin "
alias gull="git pull"
alias gcp="git cherry-pick"
alias gfo="git fetch origin"
alias gfoch="git fetch origin; git checkout"

# Docker Aliases
alias dk="docker"
alias dkc="docker-compose"

function tail-docker-pretty {
    docker logs -f $1 2>&1 | jq -R "fromjson? | . "
}

#Show CWD on prompt
PROMPT=${PROMPT/\%c/\%~}

load-tfswitch() {
    local terraform_versionfile_path="main.tf"
    
    if [ -f "$terraform_versionfile_path" ]; then
        tfswitch
    fi
}
add-zsh-hook chpwd load-tfswitch
load-tfswitch
