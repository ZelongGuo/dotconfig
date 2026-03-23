# Dotconfig

Cross-platform configuration files for macOS and Linux.

## Structure

```
~/dotconfig/
├── shared/          # Cross-platform configs → ~/.config/
│   ├── kitty/       # Terminal emulator
│   ├── lazygit/     # Git UI
│   ├── ranger/      # File manager
│   ├── tmux/        # Terminal multiplexer
│   ├── yazi/        # File manager
│   └── zsh/         # Shell configuration
├── macos/           # macOS-specific configs → ~/.config/
│   ├── aerospace/   # Tiling window manager
│   └── zsh/         # macOS-specific zsh config
├── linux/           # Linux-specific configs → ~/.config/
│   ├── wm/          # Window manager configs
│   └── zsh/         # Linux-specific zsh config
├── install.sh       # Installation script
├── Brewfile         # macOS packages
└── README.md
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
2. Create symlinks for shared configs in `~/.config/`
3. Create symlinks for OS-specific configs in `~/.config/`
4. Create home directory symlinks (`.zshrc`, `.zimrc`)

**Note:** `nvim` is maintained separately and is not included.

## Usage

### Editing configs
Edit files directly in `~/dotconfig/`:
```bash
vim ~/dotconfig/shared/zsh/zshrc
```

Changes take effect immediately (files are symlinked).

### Re-deployment
```bash
~/dotconfig/install.sh
```

### Syncing changes
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
