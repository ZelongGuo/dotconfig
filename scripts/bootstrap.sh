#!/usr/bin/env bash
# ===================================================================
# Bootstrap Script for Dotfiles
# ===================================================================
# Detects the OS and sets up the configuration

set -e

# -------------------------------------------------------------------
# Detect repository root directory dynamically
# -------------------------------------------------------------------
# This allows the dotfiles to be cloned to any location and still work.
# For example:
#   ~/.config                    -> DOTFILE_DIR = ~/.config
#   ~/.config/dotfiles-temp      -> DOTFILE_DIR = ~/.config-temp
#   ~/projects/my-dotfiles       -> DOTFILE_DIR = ~/projects/my-dotfiles
# -------------------------------------------------------------------
# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# Get the parent directory (repository root)
DOTFILE_DIR="$(dirname "$SCRIPT_DIR")"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# -------------------------------------------------------------------
# Check prerequisites
# -------------------------------------------------------------------
check_prerequisites() {
    local missing=0

    # Check for zsh
    if ! command -v zsh &>/dev/null; then
        echo -e "${RED}Error: zsh is not installed${NC}"
        echo ""
        echo "Please install zsh first:"
        if [[ "$OSTYPE" == darwin* ]]; then
            echo "  brew install zsh"
        else
            echo "  sudo apt install zsh      # Debian/Ubuntu"
            echo "  sudo pacman -S zsh        # Arch"
            echo "  sudo dnf install zsh      # Fedora"
        fi
        echo ""
        missing=1
    fi

    # Check for git
    if ! command -v git &>/dev/null; then
        echo -e "${RED}Error: git is not installed${NC}"
        echo ""
        echo "Please install git first:"
        if [[ "$OSTYPE" == darwin* ]]; then
            echo "  brew install git"
        else
            echo "  sudo apt install git      # Debian/Ubuntu"
            echo "  sudo pacman -S git        # Arch"
            echo "  sudo dnf install git      # Fedora"
        fi
        echo ""
        missing=1
    fi

    if [[ $missing -eq 1 ]]; then
        exit 1
    fi
}

check_prerequisites

# -------------------------------------------------------------------
# Detect OS
# -------------------------------------------------------------------
if [[ "$OSTYPE" == darwin* ]]; then
    CURRENT_OS="macos"
elif [[ "$OSTYPE" == linux-gnu* ]]; then
    CURRENT_OS="linux"
else
    echo -e "${RED}Unknown OS: $OSTYPE${NC}"
    exit 1
fi

echo -e "${GREEN}=========================================${NC}"
echo -e "${GREEN}Bootstrap: $CURRENT_OS detected${NC}"
echo -e "${GREEN}=========================================${NC}"

# -------------------------------------------------------------------
# Run symlink script
# -------------------------------------------------------------------
echo ""
echo "Step 1: Creating OS-specific symlinks..."
zsh "$DOTFILE_DIR/scripts/symlink.sh"

# -------------------------------------------------------------------
# Reload zsh configuration
# -------------------------------------------------------------------
echo ""
echo "Step 2: Reloading zsh configuration..."
# Export DOTFILE_DIR so zshrc can use it as fallback
export ZSH_DOTFILES_DIR="$DOTFILE_DIR"
zsh -c "source '$DOTFILE_DIR/zsh/zshrc'"

# -------------------------------------------------------------------
# Optional: Check if zsh is the default shell
# -------------------------------------------------------------------
if [[ "$SHELL" != *"zsh"* ]]; then
    echo ""
    echo -e "${YELLOW}Note: zsh is not your default shell${NC}"
    echo "To make zsh your default shell, run:"
    echo "  chsh -s \$(which zsh)"
    echo "Then log out and log back in."
fi

echo ""
echo -e "${GREEN}=========================================${NC}"
echo -e "${GREEN}Bootstrap complete!${NC}"
echo -e "${GREEN}=========================================${NC}"
