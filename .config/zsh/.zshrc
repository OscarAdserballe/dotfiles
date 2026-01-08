# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

bindkey '^[^?' backward-kill-word

plugins=(
    git
    zsh-autosuggestions
    zsh-syntax-highlighting
    docker
    history-substring-search
    colored-man-pages
)

if [ -f "$HOME/.config/secrets.zsh" ]; then
    source "$HOME/.config/secrets.zsh"
fi

if [ -f "$HOME/.secrets" ]; then
    source "$HOME/.secrets"
fi

export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"

export PATH="$HOME/.local/bin:$PATH"

ZSH_THEME="agnoster"

# Set default user to hide user@hostname
DEFAULT_USER=$USER

# Customize agnoster theme to be more minimal
prompt_context() {}  # This removes the username@hostname
prompt_dir() {
  prompt_segment blue black '%3~'  # Show only current directory
  }

# Set ZSH variables if not already set
export ZSH_CUSTOM="$ZSH/custom"
export ZSH_CACHE_DIR="$ZSH/cache"
export ZSH_COMPDUMP="$ZSH_CACHE_DIR/.zcompdump-$HOST"
export DISABLE_UPDATE_PROMPT="true"

# Source oh-my-zsh
source $ZSH/oh-my-zsh.sh


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

run_with_sound() {
  local completion_sound="$HOME/Downloads/sound_effect.wav" # <<< CHANGE THIS PATH
  local sound_player="afplay"  

  "$@"

  local exit_status=$?

  $sound_player "$completion_sound" &> /dev/null &

  return $exit_status
}

export EDITOR='nvim'
export VISUAL='nvim'

# Java 8
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh" || true

urlencode() {
    jq -rn --arg str "${1}" '$str|@uri'
}
function urldecode() { : "${*//+/ }"; echo -e "${_//%/\\x}"; }

export NVM_DIR="$HOME/.nvm"

# Create placeholder functions that load nvm when first called
nvm() {
    unset -f nvm node npm npx
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
    nvm "$@"
}

node() {
    unset -f nvm node npm npx
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
    node "$@"
}

npm() {
    unset -f nvm node npm npx
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
    npm "$@"
}

npx() {
    unset -f nvm node npm npx
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
    npx "$@"
}

# Auto-load nvm when entering directories with .nvmrc
autoload -U add-zsh-hook
load-nvmrc() {
  if [[ -f .nvmrc && -r .nvmrc ]]; then
    # Load nvm if not already loaded
    if ! command -v nvm &> /dev/null; then
      [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    fi
    nvm use
  fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc

# ===========================
# dbt aliases
alias dbtf=/Users/oscarjuliusadserballe/.local/bin/dbt

export B2025="$HOME/Google Drive/My Drive/2025B"

# setting up SSH connection
alias connect="source ~/cli_scripts/connect_ssh.sh"

# setting neovim as default
alias vim="nvim"
alias v.="nvim ."
alias v="nvim ."

alias secretsf='source "$HOME/.config/secretsfullview.zsh"'

# directory aliases
alias f='cd "$(find . -type d | fzf)"'
alias cds="cd ~/Google\ Drive/My\ Drive/2025B"
alias cdo="cd ~/Google\ Drive/My\ Drive/Obsidian"
alias cdg="cd ~/Google\ Drive/My\ Drive/"
alias cda="cd ~/kristeligt-dagblad"
alias cdf="cd ~/Fullview/git"
alias cdb="cd -"
alias cdd="cd ~/dotfiles/.config"
alias cdp="cd ~/Projects"

alias sourcez="source ~/dotfiles/.config/zsh/.zshrc"

# dbt aliases
alias dbtrun="poetry run dbt run --profiles-dir . --target prod --vars '{\"rebuild_functions\": false}' -s"
alias dbtsnapshot="poetry run dbt snapshot --profiles-dir . --target prod --vars '{\"rebuild_functions\": false}' -s"
alias dbttest="poetry run dbt test --profiles-dir . --target prod --vars '{\"rebuild_functions\": false}' -s"
alias dbtcompile="poetry run dbt compile --profiles-dir . --target prod -s"

dbtc() {
    if [ -z "$1" ]; then
        echo "Usage: dbtc <table_name>"
        return 1
    fi
    poetry run dbt compile --target prod --quiet -s "$1" | pbcopy 
}

alias transcript="python ~/Projects/get_transcripts/yt_transcript.py"
alias newspaper="python -m newspaper --output-format=text --url"
alias port-plan="python3 ~/dotfiles/scripts/claude-plan-copier.py"
