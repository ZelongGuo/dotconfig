# Tmux Configuration

Cross-platform tmux configuration with powerline status bar and plugins.

## Structure

```
tmux/
├── .tmux.conf          # Main configuration
├── fzf_panes.tmux      # FZF-based pane switching
├── tmux-powerline/     # Status bar theme (third-party)
└── extrakto/           # Text extraction plugin (third-party)
```

## Installation

The config is symlinked by the main `install.sh` script:
```bash
~/.tmux.conf → ~/dotconfig/shared/tmux/.tmux.conf
```

## Features

- **Prefix**: `Ctrl-a` (remapped from `Ctrl-b`)
- **Vim-style keybindings** in copy mode
- **Powerline status bar** with left/right sections
- **Auto tmux** - Automatically starts tmux session on shell launch
- **FZF panes** - Enhanced pane switching with fzf

## Keybindings

| Key | Action |
|-----|--------|
| `Ctrl-a` | Prefix |
| `Ctrl-a r` | Reload config |
| `-` / `\` | Split horizontal/vertical |
| `i/k/j/l` | Move up/down/left/right (Vim-style) |
| `f` | Toggle full pane |
| `q` | Kill pane |
| `p` | Paste buffer |

## Customization

### Change Status Bar

Edit `tmux-powerline/themes/default.sh`

### Troubleshooting

**Icons not showing:**
- Use Nerd Font or Powerline font in your terminal
- Run `tmux -u` for UTF-8 mode
