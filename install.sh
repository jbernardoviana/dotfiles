#!/bin/zsh


# Define a function which rename a `target` file to `target.backup` if the file
# exists and if it's a 'real' file, ie not a symlink
backup() {
  target=$1
  if [ -e "$target" ]; then
    if [ ! -L "$target" ]; then
      mv "$target" "$target.backup"
      echo "-----> Moved your old $target config file to $target.backup"
    fi
  fi
}

symlink() {
  file=$1
  link=$2
  if [ ! -e "$link" ]; then
    echo "-----> Symlinking your new $link"
    ln -s $file $link
  fi
}

# For all files `$name` in the present folder except `*.sh`, `README.md`, `settings.json`,
# and `config`, backup the target file located at `~/.$name` and symlink `$name` to `~/.$name`
for name in aliases gitconfig irbrc rspec zprofile zshrc; do
  if [ ! -d "$name" ]; then
    target="$HOME/.$name"
    backup $target
    symlink $PWD/$name $target
  fi
done

# Install zsh plugins
CURRENT_DIR=`pwd`
ZSH_PLUGINS_DIR="$HOME/.oh-my-zsh/custom/plugins"
if [ ! -d "$ZSH_PLUGINS_DIR" ]; then
  echo "-----> Creating plugins directory..."
  mkdir -p "$ZSH_PLUGINS_DIR"
fi

cd "$ZSH_PLUGINS_DIR"
if [ ! -d "zsh-autosuggestions" ]; then
  echo "-----> Installing zsh plugin 'zsh-autosuggestions'..."
  git clone https://github.com/zsh-users/zsh-autosuggestions
fi

if [ ! -d "zsh-syntax-highlighting" ]; then
  echo "-----> Installing zsh plugin 'zsh-syntax-highlighting'..."
  git clone https://github.com/zsh-users/zsh-syntax-highlighting
fi
cd "$CURRENT_DIR"

# Symlink VS Code settings and keybindings to the present `settings.json` and `keybindings.json` files
# If it's a macOS
if [[ `uname` =~ "Darwin" ]]; then
  CODE_PATH=~/Library/Application\ Support/Code/User
  CURSOR_PATH=~/Library/Application\ Support/Cursor/User
# Else, it's a Linux
else
  CODE_PATH=~/.config/Code/User
  CURSOR_PATH=~/.config/Cursor/User
  # If this folder doesn't exist, it's a WSL
  if [ ! -e $CODE_PATH ]; then
    CODE_PATH=~/.vscode-server/data/Machine
  fi
  if [ ! -e $CURSOR_PATH ]; then
    CURSOR_PATH=~/.vscode-server/data/Machine
  fi
fi

# Ensure VS Code directory exists
if [ ! -d "$CODE_PATH" ]; then
  echo "-----> Creating VS Code directory..."
  mkdir -p "$CODE_PATH"
fi

for name in settings.json keybindings.json; do
  target="$CODE_PATH/$name"
  backup $target
  symlink $PWD/$name $target
done

# Symlink Cursor settings and keybindings
if [ -d "$CURSOR_PATH" ] || [[ `uname` =~ "Darwin" ]]; then
  echo "-----> Setting up Cursor configuration..."
  
  # Ensure Cursor directory exists
  if [ ! -d "$CURSOR_PATH" ]; then
    echo "-----> Creating Cursor directory..."
    mkdir -p "$CURSOR_PATH"
  fi

  # Symlink keybindings (shared with VS Code)
  target="$CURSOR_PATH/keybindings.json"
  backup $target
  symlink $PWD/keybindings.json $target

  # Symlink Cursor-specific settings
  target="$CURSOR_PATH/settings.json"
  backup $target
  symlink $PWD/cursor-settings.json $target
fi

# Symlink SSH config file to the present `config` file for macOS and add SSH passphrase to the keychain
if [[ `uname` =~ "Darwin" ]]; then
  target=~/.ssh/config
  backup $target
  symlink $PWD/config $target
  # Use modern flags to suppress deprecation warnings
  ssh-add --apple-use-keychain ~/.ssh/id_ed25519 2>/dev/null || ssh-add -K ~/.ssh/id_ed25519
fi

# Setup Starship configuration
echo "-----> Setting up Starship configuration..."
STARSHIP_CONFIG_DIR="$HOME/.config"
if [ ! -d "$STARSHIP_CONFIG_DIR" ]; then
  echo "-----> Creating Starship config directory..."
  mkdir -p "$STARSHIP_CONFIG_DIR"
fi
target="$STARSHIP_CONFIG_DIR/starship.toml"
backup $target
symlink $PWD/starship.toml $target

# Refresh the current terminal with the newly installed configuration
exec zsh

echo "👌 Carry on with git setup!"
