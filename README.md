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
