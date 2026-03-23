# Dotconfig

Cross-platform configuration files for macOS and Linux.

## Structure

```
~/dotconfig/
├── shared/          # Cross-platform configs → ~/.config/
│   ├── nvim/
│   ├── tmux/
│   ├── zsh/
│   ├── kitty/
│   └── ...
├── macos/           # macOS-specific configs → ~/.config/
│   ├── aerospace/
│   ├── brew/
│   └── zsh/
├── linux/           # Linux-specific configs → ~/.config/
│   ├── zsh/
│   └── wm/
├── scripts/
├── install.sh
└── Brewfile
```

## Installation

```bash
# Clone repository
cd ~
git clone https://github.com/ZelongGuo/dotconfig.git
cd dotconfig

# Run installer
./install.sh
```

The installer will:
1. Detect your OS (macOS or Linux)
2. Create symlinks for shared configs
3. Create symlinks for OS-specific configs
4. Create home directory symlinks (.zshrc, .gitconfig)

## Usage

### Editing configs
Edit files directly in `~/dotconfig/`:
```bash
vim ~/dotconfig/shared/nvim/init.lua
```

### Deployment
Configs are symlinked, so changes take effect immediately.
For a full re-deployment:
```bash
~/dotconfig/install.sh
```

### Syncing
```bash
cd ~/dotconfig
git add .
git commit -m "Update config"
git push
```

## Features

- **Modular structure** - Clear separation of shared and OS-specific configs
- **Cross-platform** - macOS and Linux support
- **Symlink deployment** - Easy to update and maintain
- **Single branch** - Simple git workflow without merge conflicts

## License

MIT
