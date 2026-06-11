# Dotconfig

![macOS](https://img.shields.io/badge/macOS-supported-blue?logo=apple) ![Linux](https://img.shields.io/badge/Linux-supported-green?logo=linux) ![Homebrew](https://img.shields.io/badge/Homebrew-integrated-orange?logo=homebrew) ![License](https://img.shields.io/badge/License-MIT-yellow)

Cross-platform CLI toolchain and configuration files for macOS and Linux.

## Structure

```
~/dotconfig/
├── shared/          # Cross-platform configs → ~/.config/
│   ├── lazygit/     # Git UI configuration
│   ├── ranger/      # File manager (colorschemes, plugins, rifle)
│   ├── surfingkeys/ # Browser extension configuration
│   ├── tmux/        # Terminal multiplexer + powerline
│   ├── yazi/        # Modern file manager (themes, plugins)
│   └── zsh/         # Shell configuration (Zim framework)
│       ├── zimrc     # Zim module configuration
│       └── zshrc     # Main shell config
├── macos/           # macOS-specific configs → ~/.config/
│   ├── aerospace/   # Tiling window manager
│   ├── kitty/       # Terminal emulator
│   └── zsh/         # macOS-specific zsh settings
├── linux/           # Linux-specific configs → ~/.config/
│   ├── dunst/       # Notification daemon
│   ├── i3/          # Window manager + scripts
│   ├── kitty/       # Terminal emulator
│   ├── picom/       # Compositor
│   ├── polybar/     # Status bar + scripts
│   ├── zathura/     # PDF viewer
│   └── zsh/         # Linux-specific zsh settings
├── install.sh       # Installation script
├── Brewfile         # CLI tools managed by Homebrew
└── README.md
```

## Installation

### Prerequisites

The installer requires **Homebrew** to be installed. If not installed:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### Quick Start

```bash
# Clone repository
cd ~
git clone https://github.com/ZelongGuo/dotconfig.git
cd dotconfig

# Run installer
./install.sh
```

The installer will:
1. Check prerequisites (zsh, git, Homebrew)
2. Install CLI tools from Brewfile (stable mode)
3. Detect your OS (macOS or Linux)
4. Create symlinks for shared configs in `~/.config/`
5. Create symlinks for OS-specific configs in `~/.config/`
6. Create home directory symlinks (`.zshrc`, `.zimrc`, `.tmux.conf`)

**Note:** `nvim` is maintained separately and is not included.

## CLI Tools

The following tools are installed via Homebrew:

| Tool | Description |
|------|-------------|
| neovim | Editor |
| yazi | Modern file manager |
| ranger | Terminal file manager |
| tmux | Terminal multiplexer |
| lazygit | Git UI |
| btop | System monitor |
| fzf | Fuzzy finder |
| fd | Find alternative |
| ripgrep | Search tool |
| zoxide | Smart cd |
| jq | JSON processor |

Additional tools:
- Development: cmake, node, poppler
- Media: ffmpeg, imagemagick, highlight, sevenzip

See [Brewfile](Brewfile) for the complete list.

## Configuration Details

### Shell (Zsh + Zim)

Uses the **Zim framework** for modular Zsh configuration:

- **Main config**: `shared/zsh/zshrc` (symlinked to `~/.zshrc`)
- **Modules**: `shared/zsh/zimrc`
  - `environment` - Sane Zsh options
  - `input` - Bindkeys for input events
  - `git-info`, `duration-info` - Prompt information
  - `asciiship` - ASCII-only prompt
  - `zsh-autosuggestions` - Fish-like autosuggestions
  - `zsh-history-substring-search` - History search
  - `fast-syntax-highlighting` - Syntax highlighting
  - `fzf-tab` - Fuzzy tab completion
  - `zsh-autopair` - Auto-close brackets/quotes
  - `k` - Like `ls`
  - `zsh-z` - Smart directory jumping

### Terminal (Kitty + Tmux)

**Kitty**: Cross-platform GPU-accelerated terminal emulator

**Tmux**: Feature-rich terminal multiplexer
- Prefix: `Ctrl-a`
- Powerline status bar
- Extrakto for text extraction
- Custom keybindings

### File Managers

**Yazi**: Modern terminal file manager
- Dracula and Ayu Dark themes
- Git integration plugin
- Smart-enter and toggle-pane plugins

**Ranger**: Console file manager
- Custom colorschemes
- Plugin support
- Rifle file opener

### Window Management

**macOS**: AeroSpace tiling window manager
- i3-like tiling on macOS

**Linux**: i3 window manager
- Monitor management scripts (single/dual monitor)
- Lock screen integration
- Mac filesystem mounting support

### Desktop Environment (Linux)

- **Picom**: Compositor for transparency and blur effects
- **Polybar**: Status bar with dual monitor support
  - Launch scripts
  - Power menu
  - Player controls
- **Dunst**: Notification daemon
- **Zathura**: PDF viewer

## Usage

### Editing configs

Edit files directly in `~/dotconfig/`:
```bash
vim ~/dotconfig/shared/zsh/zshrc
```

Changes take effect immediately (files are symlinked).

### Update CLI tools
```bash
brew upgrade              # Upgrade all formulae
brew bundle --file=~/dotconfig/Brewfile  # Reinstall from Brewfile
```

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
- **Cross-platform** - macOS and Linux support via Homebrew
- **Symlink deployment** - Easy to update and maintain
- **Single branch** - Simple git workflow without merge conflicts
- **CLI toolchain** - Unified software management across platforms
- **Zim framework** - Fast, modular Zsh configuration

## License

MIT
