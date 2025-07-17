# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

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

[ -f "$HOME/.config/secrets.zsh" ] && source "$HOME/.config/secrets.zsh"

plugins=(git)

plugins=(
    git
    zsh-autosuggestions
    zsh-syntax-highlighting
    docker
    history-substring-search
    colored-man-pages
)

# Source oh-my-zsh
source $ZSH/oh-my-zsh.sh

# setting Vim mode
set -o vi

# Change cursor shape for different vi modes
cursor_mode() {
    # See https://ttssh2.osdn.jp/manual/4/en/usage/tips/vim.html for cursor shapes
    cursor_block='\e[2 q'
    cursor_beam='\e[6 q'

    function zle-keymap-select {
        if [[ ${KEYMAP} == vicmd ]]; then
            echo -ne $cursor_block
        elif [[ ${KEYMAP} == main ]] ||
             [[ ${KEYMAP} == viins ]] ||
             [[ ${KEYMAP} = '' ]]; then
            echo -ne $cursor_beam
        fi
    }

    zle-line-init() {
        echo -ne $cursor_beam
    }

    zle -N zle-keymap-select
    zle -N zle-line-init
}

cursor_mode

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

# Workaround for tailscale not working in PATH
alias tailscale="/Applications/Tailscale.app/Contents/MacOS/Tailscale"

# setting up SSH connection
alias connect="source ~/cli_scripts/connect_ssh.sh"

# setting neovim as default
alias vim="nvim"
alias v.="nvim ."
alias v="nvim ."

export EDITOR='nvim'
export VISUAL='nvim'


# directory aliases
alias cds="cd ~/Google\ Drive/My\ Drive/6th\ Semester"
alias cdo="cd ~/Google\ Drive/My\ Drive/Obsidian"
alias cdg="cd ~/Google\ Drive/My\ Drive/"
alias cdy="cd ~/Projects/Yesterdays\ Wisdom/yesterdays-wisdom"
alias cda="cd ~/Arbejde/GitHub"
alias cdb="cd -"
alias cdd="cd ~/dotfiles/.config"
alias cdp="cd ~/Projects"

alias graph="dot -Tpng"

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
    dbt compile --target prod --quiet -s "$1" | pbcopy 
}

# Compiles a dbt model and immediately runs a bq dry run on the compiled SQL.
bqcompile() {
    if [ -z "$1" ]; then
        echo "Usage: bqcompile <dbt_model_name>"
        echo "Example: bqcompile email_permissions"
        return 1
    fi

    local model_name="$1"
    local model_filename="$1.sql"

    echo "STEP 1: Compiling dbt model '$model_name'..."
    dbt compile --target prod --quiet -s "$model_name"
    
    if [ $? -ne 0 ]; then
        echo "ERROR: dbt compile failed. Aborting BigQuery dry run."
        return 1
    fi

    # Find the most recently modified compiled SQL file to avoid stale versions
    local compiled_path
    compiled_path=$(find target/compiled -type f -name "$model_filename" | sort -n | tail -1 | cut -f2- -d' ')

    if [ -z "$compiled_path" ]; then
        echo "ERROR: Could not find compiled SQL file for model '$model_name' in target/compiled/."
        return 1
    fi

    echo ""
    echo "STEP 2: Found compiled file at '$compiled_path'"
    echo "Performing BigQuery dry run..."
    echo "------------------------------------------------"
    
    bq query --use_legacy_sql=false --dry_run < "$compiled_path"
}

bqproject() {
    if [ -z "$1" ]; then
        echo "Current project:"
        gcloud config get-value project
    else
        echo "Setting project to '$1'..."
        gcloud config set project "$1"
    fi
}

bqls() {
    if [ -z "$1" ]; then
        echo "Listing all datasets in current project..."
        bq ls
    else
        local project_id
        project_id=$(gcloud config get-value project)
        if [ -z "$project_id" ]; then
            echo "GCloud project not set. Use 'bqproject <project-id>' to set one."
            return 1
        fi
        echo "Listing contents of '${project_id}:$1'..."
        bq ls --max_results=5000 "${project_id}:$1"
    fi
}


# ensure chmod +x path/to/file.py 
alias llls="run_with_sound ls"
alias llm="python ~/Projects/cli_llm/cli.py"
alias summarise_dir="llm --model pro -p paper_summary -f . -o obsidian_papers"
alias summarise_paper="llm --model pro -p paper_summary -o obsidian_papers -f"
alias llm_session="python ~/Projects/cli_llm/session_cli.py"
alias transcript="python ~/Projects/get_transcripts/yt_transcript.py"

format_transcript() {
  python ~/Projects/get_transcripts/yt_transcript.py "$@" \
   | llm "Can you format this transcript more nicely as well as add subheadings for different sections? Output no metatext and only the cleaned text"
}

alias newspaper="python -m newspaper --output-format=text --url"

# modifying commands inplace
alias ls="ls -1lth"
alias listall="ls -ltha"
alias pytest="sudo poetry run pytest -v -s --pdb"
alias tree="tree -I '__pycache__|.git|node_modules|venv|log'"
alias gp="run_with_sound git push"

# Java 8
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh" || true

urlencode() {
    jq -rn --arg str "${1}" '$str|@uri'
}
function urldecode() { : "${*//+/ }"; echo -e "${_//%/\\x}"; }

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

# Lazy load NVM
export NVM_DIR="$HOME/.nvm"
lazy_load_nvm() {
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
}

# Add aliases for common Node commands to trigger the load
alias nvm='unalias nvm node npm npx; lazy_load_nvm; nvm "$@"'
alias node='unalias nvm node npm npx; lazy_load_nvm; node "$@"'
alias npm='unalias nvm node npm npx; lazy_load_nvm; npm "$@"'
alias npx='unalias nvm node npm npx; lazy_load_nvm; npx "$@"'

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/oscarjuliusadserballe/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/oscarjuliusadserballe/google-cloud-sdk/path.zsh.inc'; fi

eval "$(pyenv init -)"
