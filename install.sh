#!/usr/bin/env bash
# ===================================================================
# Install Script for Dotconfig
# ===================================================================
# Creates symlinks from ~/dotconfig to ~/.config and ~/

# Exit if there is any error thrown
set -e

# -------------------------------------------------------------------
# Detect repository root directory
# -------------------------------------------------------------------
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTCONFIG_DIR="$SCRIPT_DIR"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# -------------------------------------------------------------------
# Check prerequisites
# -------------------------------------------------------------------
check_prerequisites() {
    local missing=0

    if ! command -v zsh &>/dev/null; then
        echo -e "${RED}Error: zsh is not installed${NC}"
        echo "  brew install zsh     # macOS"
        echo "  sudo apt install zsh # Linux"
        missing=1
    fi

    if ! command -v git &>/dev/null; then
        echo -e "${RED}Error: git is not installed${NC}"
        echo "  brew install git     # macOS"
        echo "  sudo apt install git # Linux"
        missing=1
    fi

    if ! command -v brew &>/dev/null; then
        echo -e "${RED}Error: Homebrew is not installed${NC}"
        echo "  /bin/bash -c \"\$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\""
        missing=1
    fi

    if [[ $missing -eq 1 ]]; then
        exit 1
    fi
}

# -------------------------------------------------------------------
# Install software from Brewfile
# -------------------------------------------------------------------
install_brewfile() {
    local brewfile="$DOTCONFIG_DIR/Brewfile"
    if [[ -f "$brewfile" ]]; then
        echo -e "${YELLOW}Installing software from Brewfile (--no-upgrade mode)...${NC}"
        brew bundle --file="$brewfile" --no-upgrade
    fi
}

check_prerequisites
install_brewfile

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

echo -e "${GREEN}========================================${NC}"
echo -e "${GREEN}Dotconfig Installer: $CURRENT_OS${NC}"
echo -e "${GREEN}========================================${NC}"
echo -e "Repository: ${BLUE}$DOTCONFIG_DIR${NC}"
echo ""

# -------------------------------------------------------------------
# Create symlinks for shared configs
# -------------------------------------------------------------------
echo -e "${YELLOW}Step 1: Creating symlinks for shared configs...${NC}"

SHARED_DIR="$DOTCONFIG_DIR/shared"
if [[ -d "$SHARED_DIR" ]]; then
    for app in "$SHARED_DIR"/*; do
        if [[ -d "$app" ]]; then
            app_name=$(basename "$app")
            target="$HOME/.config/$app_name"

            # Remove existing symlink or backup regular file
            if [[ -L "$target" ]]; then
                rm "$target"
            elif [[ -e "$target" ]]; then
                mv "$target" "$target.backup.$(date +%s)"
            fi

            ln -sf "$app" "$target"
            echo -e "  ${GREEN}✓${NC} $app_name → ~/.config/$app_name"
        fi
    done
else
    echo -e "  ${YELLOW}Warning: shared/ directory not found${NC}"
fi

# -------------------------------------------------------------------
# Create symlinks for OS-specific configs
# -------------------------------------------------------------------
echo ""
echo -e "${YELLOW}Step 2: Creating symlinks for $CURRENT_OS configs...${NC}"

OS_DIR="$DOTCONFIG_DIR/$CURRENT_OS"
if [[ -d "$OS_DIR" ]]; then
    # Handle directories in OS-specific folder
    for item in "$OS_DIR"/*; do
        if [[ -d "$item" ]]; then
            item_name=$(basename "$item")

            # Special handling for zsh directory
            if [[ "$item_name" == "zsh" ]]; then
                # OS-specific zsh configs are loaded by the main zshrc
                echo -e "  ${BLUE}○${NC} zsh (loaded by main zshrc)"
                continue
            fi

            target="$HOME/.config/$item_name"

            # Remove existing symlink or backup regular file
            if [[ -L "$target" ]]; then
                rm "$target"
            elif [[ -e "$target" ]]; then
                mv "$target" "$target.backup.$(date +%s)"
            fi

            ln -sf "$item" "$target"
            echo -e "  ${GREEN}✓${NC} $item_name → ~/.config/$item_name"
        fi
    done
else
    echo -e "  ${YELLOW}Warning: $CURRENT_OS/ directory not found${NC}"
fi

# -------------------------------------------------------------------
# Create symlink for .zshrc
# -------------------------------------------------------------------
echo ""
echo -e "${YELLOW}Step 3: Creating home directory symlinks...${NC}"

# Link .zshrc
if [[ -f "$DOTCONFIG_DIR/shared/zsh/zshrc" ]]; then
    ln -sf "$DOTCONFIG_DIR/shared/zsh/zshrc" "$HOME/.zshrc"
    echo -e "  ${GREEN}✓${NC} .zshrc → ~/dotconfig/shared/zsh/zshrc"
fi

# Link .zimrc
if [[ -f "$DOTCONFIG_DIR/shared/zsh/zimrc" ]]; then
    ln -sf "$DOTCONFIG_DIR/shared/zsh/zimrc" "$HOME/.zimrc"
    echo -e "  ${GREEN}✓${NC} .zimrc → ~/dotconfig/shared/zsh/zimrc"
fi

# Link .tmux.conf
if [[ -f "$DOTCONFIG_DIR/shared/tmux/.tmux.conf" ]]; then
    ln -sf "$DOTCONFIG_DIR/shared/tmux/.tmux.conf" "$HOME/.tmux.conf"
    echo -e "  ${GREEN}✓${NC} .tmux.conf → ~/dotconfig/shared/tmux/.tmux.conf"
fi

# Link .claude/skills (if .claude directory exists)
if [[ -d "$HOME/.claude" ]]; then
    if [[ -d "$DOTCONFIG_DIR/shared/skills" ]]; then
        ln -sf "$DOTCONFIG_DIR/shared/skills" "$HOME/.claude/skills"
        echo -e "  ${GREEN}✓${NC} .claude/skills → ~/dotconfig/shared/skills"
    fi
fi

# -------------------------------------------------------------------
# Summary
# -------------------------------------------------------------------
echo ""
echo -e "${GREEN}========================================${NC}"
echo -e "${GREEN}Installation complete!${NC}"
echo -e "${GREEN}========================================${NC}"
echo ""
echo "Next steps:"
echo "  1. Reload shell: ${BLUE}source ~/.zshrc${NC}"
echo "  2. Or restart terminal"
echo ""
