# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Fix backspace behavior
bindkey '^[^?' backward-kill-word

# Plugins (Ensure you run the git clone commands for autosuggestions/highlighting)
plugins=(
    git
    zsh-autosuggestions
    zsh-syntax-highlighting
    docker
    history-substring-search
    colored-man-pages
)

if [ -f "$HOME/.secrets" ]; then
    source "$HOME/.secrets"
fi

# Path configuration
export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
export PATH="$HOME/.local/bin:$PATH"

# Theme Configuration
ZSH_THEME="agnoster"
DEFAULT_USER=$USER
prompt_context() {}  # Removes username@hostname
prompt_dir() {
  prompt_segment blue black '%3~'  # Show only current directory
}

# OMZ Settings
export ZSH_CUSTOM="$ZSH/custom"
export ZSH_CACHE_DIR="$ZSH/cache"
export ZSH_COMPDUMP="$ZSH_CACHE_DIR/.zcompdump-$HOST"
export DISABLE_UPDATE_PROMPT="true"

# Source oh-my-zsh
source $ZSH/oh-my-zsh.sh

# Completion settings
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format '%F{green}-- %d --%f'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format '%F{red}No matches for:%f %d'
zstyle ':completion:*:corrections' format '%F{yellow}!- %d (errors: %e) -!%f'

autoload -Uz compinit && compinit

# History settings
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history
setopt SHARE_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_REDUCE_BLANKS
setopt HIST_VERIFY

# Utility functions
run_with_sound() {
  local completion_sound="$HOME/Downloads/sound_effect.wav"
  local sound_player="afplay"  
  "$@"
  local exit_status=$?
  $sound_player "$completion_sound" &> /dev/null &
  return $exit_status
}

export EDITOR='nvim'
export VISUAL='nvim'

# Java
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"

# iTerm2 Integration
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh" || true

urlencode() { jq -rn --arg str "${1}" '$str|@uri'; }
function urldecode() { : "${*//+/ }"; echo -e "${_//%/\\x}"; }

# ==============================================================================
# NVM CONFIGURATION (Homebrew Optimized)
# ==============================================================================
export NVM_DIR="$HOME/.nvm"
[ ! -d "$NVM_DIR" ] && mkdir -p "$NVM_DIR"

nvm() {
    unset -f nvm node npm npx
    local BREW_NVM_PATH="$(brew --prefix nvm)/nvm.sh"
    [ -s "$BREW_NVM_PATH" ] && \. "$BREW_NVM_PATH"
    nvm "$@"
}

node() { nvm > /dev/null; node "$@" }
npm() { nvm > /dev/null; npm "$@" }
npx() { nvm > /dev/null; npx "$@" }

autoload -U add-zsh-hook
load-nvmrc() {
  if [[ -f .nvmrc && -r .nvmrc ]]; then
    if ! command -v nvm &> /dev/null; then
       local BREW_NVM_PATH="$(brew --prefix nvm)/nvm.sh"
       [ -s "$BREW_NVM_PATH" ] && \. "$BREW_NVM_PATH"
    fi
    nvm use
  fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc

# ==============================================================================
# ALIASES
# ==============================================================================
alias dbtf=/Users/oscarjuliusadserballe/.local/bin/dbt
export B2025="$HOME/Google Drive/My Drive/2025B"

alias vim="nvim"
alias v.="nvim ."
alias v="nvim ."
# Directory aliases
alias f='cd "$(find . -type d | fzf)"'
alias cds="cd ~/Google\ Drive/My\ Drive/2025B"
alias cdo="cd ~/Google\ Drive/My\ Drive/Obsidian"
alias cdg="cd ~/Google\ Drive/My\ Drive/"
alias cda="cd ~/kristeligt-dagblad"
alias cdf="cd ~/Fullview/git"
alias cdb="cd -"
alias cdd="cd ~/dotfiles/.config"
alias cdp="cd ~/Projects"
alias sourcez="source ~/.zshrc"

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
