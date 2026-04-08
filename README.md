# Dotconfig

<!-- <img src="https://img.shields.io/badge/macOS-supported-blue?logo=apple" alt="macOS"/> -->
<!-- <img src="https://img.shields.io/badge/Linux-supported-green?logo=linux" alt="Linux"/> -->
<!-- <img src="https://img.shields.io/badge/Homebrew-integrated-orange?logo=homebrew" alt="Homebrew"/> -->
<!-- <img src="https://img.shields.io/badge/License-MIT-yellow" alt="License"/> -->
![macOS](https://img.shields.io/badge/macOS-supported-blue?logo=apple) ![Linux](https://img.shields.io/badge/Linux-supported-green?logo=linux) ![Homebrew](https://img.shields.io/badge/Homebrew-integrated-orange?logo=homebrew) ![License](https://img.shields.io/badge/License-MIT-yellow)

Cross-platform CLI toolchain and configuration files for macOS and Linux.

## Structure

```
~/dotconfig/
├── shared/          # Cross-platform configs → ~/.config/
│   ├── lazygit/     # Git UI
│   ├── ranger/      # File manager
│   ├── surfingkeys/ # Browser extension
│   ├── skills/      # Claude/AI skills
│   ├── tmux/        # Terminal multiplexer
│   ├── yazi/        # File manager
│   └── zsh/         # Shell configuration
├── macos/           # macOS-specific configs → ~/.config/
│   ├── aerospace/   # Tiling window manager
│   ├── kitty/       # Terminal emulator
│   └── zsh/         # macOS-specific zsh config
├── linux/           # Linux-specific configs → ~/.config/
│   ├── kitty/       # Terminal emulator
│   ├── wm/          # Window manager configs
│   └── zsh/         # Linux-specific zsh config
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
2. Install CLI tools from Brewfile (using `--no-upgrade` mode)
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
| yazi | File manager |
| tmux | Terminal multiplexer |
| lazygit | Git UI |
| btop | System monitor |
| fzf | Fuzzy finder |
| fd | Find alternative |
| ripgrep | Search tool |
| zoxide | Smart cd |
| jq | JSON processor |

See [Brewfile](Brewfile) for the complete list.

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

## License

MIT
