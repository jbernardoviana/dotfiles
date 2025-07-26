ZSH=$HOME/.oh-my-zsh

# You can change the theme with another one from https://github.com/robbyrussell/oh-my-zsh/wiki/themes
# ZSH_THEME="robbyrussell"  # Disabled for Starship

# Useful oh-my-zsh plugins for Le Wagon bootcamps
plugins=(git gitfast last-working-dir common-aliases zsh-syntax-highlighting history-substring-search ssh-agent direnv)

# (macOS-only) Prevent Homebrew from reporting - https://github.com/Homebrew/brew/blob/master/docs/Analytics.md
export HOMEBREW_NO_ANALYTICS=1

# Disable warning about insecure completion-dependent directories
ZSH_DISABLE_COMPFIX=true

# Actually load Oh-My-Zsh
source "${ZSH}/oh-my-zsh.sh"
unalias rm # No interactive rm by default (brought by plugins/common-aliases)
unalias lt # we need `lt` for https://github.com/localtunnel/localtunnel

# Load rbenv if installed (to manage your Ruby versions)
export PATH="${HOME}/.rbenv/bin:${PATH}" # Needed for Linux/WSL
type -a rbenv > /dev/null && eval "$(rbenv init -)"

# Load pyenv (to manage your Python versions)
export PYENV_VIRTUALENV_DISABLE_PROMPT=1
type -a pyenv > /dev/null && eval "$(pyenv init -)" && eval "$(pyenv virtualenv-init - 2> /dev/null)"

# Load nvm (to manage your node versions)
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Call `nvm use` automatically in a directory with a `.nvmrc` file
autoload -U add-zsh-hook
load-nvmrc() {
  if nvm -v &> /dev/null; then
    local node_version="$(nvm version)"
    local nvmrc_path="$(nvm_find_nvmrc)"

    if [ -n "$nvmrc_path" ]; then
      local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

      if [ "$nvmrc_node_version" = "N/A" ]; then
        nvm install
      elif [ "$nvmrc_node_version" != "$node_version" ]; then
        nvm use --silent
      fi
    elif [ "$node_version" != "$(nvm version default)" ]; then
      nvm use default --silent
    fi
  fi
}
type -a nvm > /dev/null && add-zsh-hook chpwd load-nvmrc
type -a nvm > /dev/null && load-nvmrc

# Rails and Ruby uses the local `bin` folder to store binstubs.
# So instead of running `bin/rails` like the doc says, just run `rails`
# Same for `./node_modules/.bin` and nodejs
export PATH="./bin:./node_modules/.bin:${PATH}:/usr/local/sbin"

# Store your own aliases in the ~/.aliases file and load the here.
[[ -f "$HOME/.aliases" ]] && source "$HOME/.aliases"

# Useful functions
function mkcd() {
  mkdir -p "$1" && cd "$1"
}

function extract() {
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1     ;;
      *.tar.gz)    tar xzf $1     ;;
      *.bz2)       bunzip2 $1     ;;
      *.rar)       unrar e $1     ;;
      *.gz)        gunzip $1      ;;
      *.tar)       tar xf $1      ;;
      *.tbz2)      tar xjf $1     ;;
      *.tgz)       tar xzf $1     ;;
      *.zip)       unzip $1       ;;
      *.Z)         uncompress $1  ;;
      *.7z)        7z x $1        ;;
      *)     echo "'$1' cannot be extracted via extract()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

function wttr() {
  curl "wttr.in/${1:-lisbon}"
}

function port() {
  lsof -i :$1
}

function killport() {
  kill -9 $(lsof -t -i:$1)
}

# Development helper functions
function rails_server() {
  if [ -f "bin/rails" ]; then
    bin/rails server
  elif [ -f "script/rails" ]; then
    script/rails server
  else
    rails server
  fi
}

function rails_console() {
  if [ -f "bin/rails" ]; then
    bin/rails console
  elif [ -f "script/rails" ]; then
    script/rails console
  else
    rails console
  fi
}

function python_server() {
  if [ -f "manage.py" ]; then
    python manage.py runserver
  elif [ -f "app.py" ]; then
    python app.py
  else
    python -m http.server 8000
  fi
}

function jupyter_notebook() {
  if command -v jupyter >/dev/null 2>&1; then
    jupyter notebook
  else
    echo "Jupyter not found. Install with: pip install jupyter"
  fi
}


function git_cleanup() {
  git branch --merged | grep -v "\*" | xargs -n 1 git branch -d
  git remote prune origin
}

function docker_cleanup() {
  docker system prune -f
  docker volume prune -f
  docker network prune -f
}

function show_versions() {
  echo "🐍 Python: $(python --version 2>/dev/null || echo 'Not installed')"
  echo "💎 Ruby: $(ruby --version 2>/dev/null || echo 'Not installed')"
  echo "📦 Node: $(node --version 2>/dev/null || echo 'Not installed')"
  echo "🐳 Docker: $(docker --version 2>/dev/null || echo 'Not installed')"
  echo "🍺 Homebrew: $(brew --version 2>/dev/null | head -n1 || echo 'Not installed')"
}

# Initialize Starship prompt
eval "$(starship init zsh)"

# Enhanced history search
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# Better tab completion
autoload -U compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

# Command done chime (optional - uncomment if you want it)
# precmd() { ( play --no-show-progress --single-threaded -v 2 /System/Library/Sounds/Glass.aiff & ) }

# Enhanced directory navigation
setopt auto_cd
setopt auto_pushd
setopt pushd_ignore_dups
setopt pushdminus

# Better history
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_verify
setopt share_history

# Enhanced globbing
setopt extended_glob
setopt nomatch
setopt notify

# Encoding stuff for the terminal
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

export BUNDLER_EDITOR=code
export EDITOR=code

# Set ipdb as the default Python debugger
export PYTHONBREAKPOINT=ipdb.set_trace

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/opt/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc' ]; then . '/opt/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/opt/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc' ]; then . '/opt/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc'; fi


# Google Cloud credentials - set this in your environment or create the file
if [ -f "$HOME/code/jbernardoviana/gcp_keys/lewagon-305217-13e3d6f7cd81.json" ]; then
  export GOOGLE_APPLICATION_CREDENTIALS="$HOME/code/jbernardoviana/gcp_keys/lewagon-305217-13e3d6f7cd81.json"
fi

