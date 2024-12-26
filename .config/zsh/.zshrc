# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

[ -f "$HOME/.config/secrets.zsh" ] && source "$HOME/.config/secrets.zsh"

plugins=(git)

source $ZSH/oh-my-zsh.sh
# Enable plugins
plugins=(
    git
    zsh-autosuggestions
    zsh-syntax-highlighting
    docker
    command-not-found
    history-substring-search
    colored-man-pages
)

# Source oh-my-zsh
source $ZSH/oh-my-zsh.sh

# setting Vim mode
set -o vi

# Better completion settings
zstyle ':completion:*' menu select  # Enable menu selection
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'  # Case insensitive matching
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"    # Colored completion
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format '%F{green}-- %d --%f'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format '%F{red}No matches for:%f %d'
zstyle ':completion:*:corrections' format '%F{yellow}!- %d (errors: %e) -!%f'

# Initialize completion
autoload -Uz compinit && compinit

# History settings
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history
setopt SHARE_HISTORY             # Share history between sessions
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first
setopt HIST_IGNORE_DUPS          # Don't record duplicates
setopt HIST_FIND_NO_DUPS        # No duplicates in history search
setopt HIST_REDUCE_BLANKS       # Remove extra blanks
setopt HIST_VERIFY              # Verify history expansion
#
#export CLICOLOR=1
PS1="%F{black}${PS1}"

# If you're still seeing colored text for commands, also add:
export LSCOLORS=exfxcxdxbxegedabagacad
export PS1='%F{black}%~ %# '

export PATH="/opt/homebrew/anaconda3/bin:$PATH"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/oscarjuliusadserballe/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/oscarjuliusadserballe/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/oscarjuliusadserballe/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/oscarjuliusadserballe/google-cloud-sdk/completion.zsh.inc'; fi

export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"

# ensuring poetry in path
export PATH="/Users/oscarjuliusadserballe/.local/bin:$PATH"


### SSH KEYS ###
# start ssh-agent
alias connect="sh ~/cli_scripts/connect_ssh.sh"
### END SSH KEYS ###

# setting neovim as default
alias vim="nvim"
alias v.="nvim ."
export EDITOR='nvim'
export VISUAL='nvim'


# directory aliases
alias cdo="cd ~/OneDrive/Obsidian"
alias cds="cd ~/OneDrive/5th\ Semester"
alias cdy="cd ~/OneDrive/5th\ Semester/Yesterdays\ Wisdom/yesterdays-wisdom"
alias cda="cd ~/Arbejde/GitHub"
alias cdb="cd -"
alias cdconfig="cd ~/dotfiles/.config"

# code aliases
alias codes="code ~/Arbejde/GitHub/streamlit-app"
alias codez="code ~/.zshrc"
alias coded="code ~/dbt"

alias sourcez="source ~/.zshrc"

# dbt aliases
alias dbtrun="dbt run --profiles-dir . --target prod -s"
alias dbtcompile="dbt compile --profiles-dir . --target prod -s"

# git aliases
alias gs="git status"
alias ga="git add"
alias gc="git commit"
alias gp="git push"
alias gpl="git pull"
alias gco="git checkout"
alias gb="git branch"
alias gitlog="git log --all --graph --decorate"
alias ttest="poetry run pytest -v -s -x --durations=0"

# gcloud aliases
alias gcpset="gcloud config set project"

# ensure chmod +x ~/cli_scripts/{filename}.py
alias llm="~/cli_scripts/cli_llm.py"
alias rag="~/cli_scripts/cli_rag.py"
alias latex="~/cli_scripts/cli_latex.py"


# modifying commands inplace
alias ls="ls -1lth"
alias listall="ls -ltha"
alias pytest="sudo poetry run pytest -v -s --pdb"
alias tree="tree -I '__pycache__|.git|node_modules|venv|log'"

# Java 8
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh" || true

## Opening tmux session on startup
if [ -z "$TMUX" ]; then # checking that tmux is not already running to prevent nested sessions
    tmux attach -t obsidian || tmux new -s obsidian
fi


# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='nvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
#
#export ZSH="$HOME/.oh-my-zsh"


# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.

