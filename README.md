# João Viana's Dotfiles

This repository contains my personal dotfiles configuration for macOS development environment.

## 🛠️ Included Tools

- [oh-my-zsh](http://ohmyz.sh/) - Enhanced shell configuration with plugins
- [Starship](https://starship.rs/) - Fast, minimal, and customizable prompt
- [Visual Studio Code](https://code.visualstudio.com/) - Editor settings and keybindings
- [Cursor](https://cursor.sh/) - AI-powered editor settings and keybindings
- [git](https://git-scm.com/) - Git configuration and aliases
- [SSH](https://www.openssh.com/) - SSH configuration for remote development
- [iTerm2](https://iterm2.com/) - Terminal preferences and color schemes

## 📁 Configuration Files

- **Shell**: `.zshrc`, `.zprofile`, `.aliases`
- **Starship**: `~/.config/starship.toml` (clean, minimal prompt)
- **Git**: `.gitconfig` (comprehensive aliases and optimized settings)
- **Ruby**: `.irbrc`, `.rspec`
- **SSH**: `config` (symlinked to `~/.ssh/config`)
- **iTerm2**: `iterm2/` directory (JSON profile exports)
- **VS Code**: `settings.json`, `keybindings.json`
- **Cursor**: `cursor-settings.json`, `keybindings.json` (shared with VS Code)

### Before installation, check LW setup:
Check this https://github.com/lewagon/setup/blob/master/macos.md


## 🚀 Installation

<details>
<summary><strong>Quick Setup (Click to expand)</strong></summary>

1. Clone this repository:
   ```bash
   git clone https://github.com/jbernardoviana/dotfiles.git
   cd dotfiles
   ```

2. Run the installation script:
   ```bash
   ./install.sh
   ```

The script will:
- Backup existing configuration files
- Create symlinks to the dotfiles
- Install zsh plugins (zsh-autosuggestions, zsh-syntax-highlighting)
- Configure SSH with keychain integration
- Set up VS Code settings
- Set up Cursor settings (if installed)
- Initialize Starship prompt (clean, minimal configuration)

**Note:** For iTerm2 profiles, export your current profiles as JSON files to the `iterm2/` directory. See `iterm2/README.md` for instructions.

</details>

<details>
<summary><strong>Complete New MacBook Setup Guide (Click to expand)</strong></summary>

### 1. **Initial Setup**
```bash
# Clone your dotfiles
git clone https://github.com/jbernardoviana/dotfiles.git
cd dotfiles

# Run the main installation script
./install.sh
```

### 2. **Install Required Tools**

#### **Homebrew** (Package Manager)
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

#### **Essential Tools**
```bash
# Install the tools your dotfiles expect
brew install git
brew install zsh
brew install starship
brew install rbenv
brew install pyenv
brew install nvm
```

#### **Applications**
```bash
# Install applications
brew install --cask iterm2
brew install --cask visual-studio-code
brew install --cask cursor
```

### 3. **Configure Each Application**

#### **iTerm2**
```bash
# Import your iTerm2 profiles
# 1. Open iTerm2
# 2. Go to File > Import Profile...
# 3. Select the file from: dotfiles/iterm2/iTerm2 State.itermexport
```

#### **VS Code & Cursor**
- The `install.sh` script already symlinked your settings
- VS Code settings: `~/Library/Application Support/Code/User/settings.json`
- Cursor settings: `~/Library/Application Support/Cursor/User/settings.json`
- Keybindings are shared between both editors

#### **Shell (Zsh)**
- Oh-My-Zsh will be installed automatically
- Your `.zshrc` and `.aliases` are already symlinked
- Starship prompt is configured

### 4. **SSH Setup**
```bash
# Generate SSH key (if you don't have one)
ssh-keygen -t ed25519 -C "your-email@example.com"

# Add to SSH agent
ssh-add --apple-use-keychain ~/.ssh/id_ed25519

# Your SSH config is already symlinked from dotfiles/config
```

### 5. **Development Environment**

#### **Ruby (via rbenv)**
```bash
# Install Ruby
rbenv install 3.2.2  # or whatever version you need
rbenv global 3.2.2
gem install bundler
```

#### **Python (via pyenv)**
```bash
# Install Python
pyenv install 3.11.0  # or whatever version you need
pyenv global 3.11.0
pip install ipdb  # for debugging
```

#### **Node.js (via nvm)**
```bash
# Install Node.js
nvm install 18  # or whatever version you need
nvm use 18
nvm alias default 18
```

### 6. **Verify Everything Works**
```bash
# Test your setup
versions  # Shows all installed versions
wttr      # Test weather function
weather   # Opens macOS Weather app
```

## 🎯 Quick Checklist

- [ ] Clone dotfiles and run `./install.sh`
- [ ] Install Homebrew and essential tools
- [ ] Install iTerm2, VS Code, Cursor
- [ ] Import iTerm2 profiles
- [ ] Set up SSH keys
- [ ] Install Ruby, Python, Node.js
- [ ] Test all functions and aliases

## 🔧 What Gets Automatically Configured

✅ **Shell**: Zsh with Oh-My-Zsh, Starship prompt, aliases  
✅ **Git**: Configuration and aliases  
✅ **VS Code**: Settings and keybindings  
✅ **Cursor**: Settings and keybindings  
✅ **SSH**: Config file  
✅ **iTerm2**: Profile import ready  

## 🎯 One-Liner Setup (After Homebrew)

```bash
git clone https://github.com/jbernardoviana/dotfiles.git && cd dotfiles && ./install.sh && brew install --cask iterm2 visual-studio-code cursor
```

</details>

## 🔧 Customization

### Git Aliases

The Git configuration includes comprehensive aliases for common operations. Note: Some short aliases (like `s`, `d`, `l`) were removed to avoid conflicts with shell aliases:

**Basic Commands:**
- `git gs` - status
- `git ga` - add
- `git gc` - commit
- `git gp` - push
- `git gl` - log --oneline
- `git gd` - diff
- `git co` / `git gco` - checkout
- `git gcb` - checkout -b

**Enhanced Commands:**
- `git st` / `git gst` - status -sb (short format)
- `git log` / `git glog` - log with graph and decorations
- `git diff` / `git gdiff` - diff with word highlighting
- `git pull` / `git gpull` - pull with rebase
- `git sweep` - clean merged branches
- `git mop` - remove gone remote branches

### Environment-Specific Settings

Some settings are environment-aware and will only be applied if the required files/directories exist:

- Google Cloud credentials (`GOOGLE_APPLICATION_CREDENTIALS`)
- Le Wagon Python path (`PYTHONPATH`)

### SSH Key Management

**Important:** SSH keys are **NOT** managed by this dotfiles repository. They should be stored in their original location.

**Where to add SSH keys:**
- **SSH Keys**: `~/.ssh/id_ed25519`, `~/.ssh/id_rsa`, etc. (original location)
- **SSH Config**: `~/.ssh/config` (symlinked to `dotfiles/config`)

**Best practices:**
1. **SSH Keys** → Store in `~/.ssh/` (original location, not in dotfiles)
2. **SSH Config** → Edit `dotfiles/config` (will sync to `~/.ssh/config`)

**Example workflow:**
```bash
# Generate new SSH key (in original location)
ssh-keygen -t ed25519 -C "your-email@example.com" -f ~/.ssh/id_ed25519_new

# Add to SSH config (edit the dotfiles version)
code ~/code/jbernardoviana/dotfiles/config

# The config change will automatically sync to ~/.ssh/config
```

### Adding New Configurations

1. Add your configuration file to the repository
2. Update the `install.sh` script to include the new file in the symlink loop
3. Run `./install.sh` to apply changes

## 🔒 Security Notes

- SSH keys are referenced but not included in this repository
- Sensitive files are excluded via `.gitignore`
- The SSH config uses macOS keychain integration

## 🐛 Troubleshooting

### Broken Symlinks
If you encounter broken symlinks, run:
```bash
./install.sh
```

### SSH Issues
Ensure your SSH keys exist:
```bash
ls -la ~/.ssh/id_ed25519 ~/.ssh/id_rsa
```

### VS Code Settings Not Applied
Check if VS Code is installed and the settings directory exists:
```bash
ls -la ~/Library/Application\ Support/Code/User/
```

## 📝 License

This project is for personal use. Feel free to fork and adapt for your own needs.
