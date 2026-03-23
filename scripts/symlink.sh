#!/usr/bin/env zsh
# ===================================================================
# Symlink Management Script
# ===================================================================
# Creates all necessary symlinks for dotfiles setup
# - Cross-platform config symlinks
# - OS-specific config symlinks

set -e

# -------------------------------------------------------------------
# Detect repository root directory dynamically
# -------------------------------------------------------------------
# This allows the dotfiles to be cloned to any location and still work.
# Uses zsh-compatible syntax since this script runs with zsh.
# -------------------------------------------------------------------
# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
# Get the parent directory (repository root)
DOTFILE_DIR="$(dirname "$SCRIPT_DIR")"
OS_DIR="$DOTFILE_DIR/os"

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

# -------------------------------------------------------------------
# Create a symlink, replacing existing symlinks if needed
# -------------------------------------------------------------------
# Behavior:
#   - If target doesn't exist: create symlink
#   - If target is a symlink pointing to source: OK (skip)
#   - If target is a symlink pointing elsewhere: remove and recreate
#   - If target is a regular file/directory: skip (preserve user data)
# -------------------------------------------------------------------
create_symlink() {
    local source="$1"
    local target="$2"
    local name="$3"

    # Skip if source doesn't exist
    if [[ ! -e "$source" ]]; then
        echo "  ${YELLOW}Skipping${NC}: $name (source not found: $source)"
        return
    fi

    # Handle existing targets
    if [[ -e "$target" || -L "$target" ]]; then
        if [[ -L "$target" ]]; then
            # Existing symlink - check if it points to the right place
            local current_target=$(readlink "$target")
            if [[ "$current_target" == "$source" ]]; then
                echo "  ${GREEN}OK${NC}: $name"
                return
            fi
            # Remove incorrect symlink and recreate
            rm "$target"
            ln -s "$source" "$target"
            echo "  ${GREEN}Replaced${NC}: $name (old symlink: $current_target)"
            return
        else
            # Regular file or directory - skip to preserve user data
            echo "  ${YELLOW}Skipping${NC}: $name (existing file/directory, not overwriting)"
            return
        fi
    fi

    # Create the symlink
    ln -s "$source" "$target"
    echo "  ${GREEN}Created${NC}: $name"
}

# -------------------------------------------------------------------
# Detect OS
# -------------------------------------------------------------------
if [[ "$OSTYPE" == darwin* ]]; then
    CURRENT_OS="macos"
elif [[ "$OSTYPE" == linux-gnu* ]]; then
    CURRENT_OS="linux"
else
    echo "Unknown OS: $OSTYPE"
    exit 1
fi

echo "Detected OS: $CURRENT_OS"

# -------------------------------------------------------------------
# Cross-platform symlinks (created on all systems)
# -------------------------------------------------------------------
echo ""
echo "Creating cross-platform symlinks..."

create_symlink "$DOTFILE_DIR/zsh/zshrc" "$HOME/.zshrc" ".zshrc"
create_symlink "$DOTFILE_DIR/zsh/zimrc" "$HOME/.zimrc" ".zimrc"
create_symlink "$DOTFILE_DIR/zsh/.gmtversions" "$HOME/.gmtversions" ".gmtversions"
create_symlink "$DOTFILE_DIR/tmux/.tmux.conf" "$HOME/.tmux.conf" ".tmux.conf"
create_symlink "$DOTFILE_DIR/zsh/.shared" "$HOME/.shared" ".shared"
create_symlink "$DOTFILE_DIR/opencode/skills" "$HOME/.claude/skills" "claude/skills"

# -------------------------------------------------------------------
# OS-specific symlinks
# -------------------------------------------------------------------
echo ""
echo "Creating OS-specific symlinks..."

if [[ "$CURRENT_OS" == "macos" ]]; then
    # macOS-only directories
    local macos_only=("aerospace" "iterm2" "brew")

    for name in "${macos_only[@]}"; do
        local source="$OS_DIR/macos/$name"
        local target="$DOTFILE_DIR/$name"
        create_symlink "$source" "$target" "$name -> os/macos/$name"
    done
fi

if [[ "$CURRENT_OS" == "linux" ]]; then
    # Linux-specific directories (for future use)
    if [[ -d "$OS_DIR/linux" ]]; then
        for dir in "$OS_DIR/linux"/*; do
            if [[ -d "$dir" ]]; then
                local name=$(basename "$dir")
                local source="$dir"
                local target="$DOTFILE_DIR/$name"
                create_symlink "$source" "$target" "$name -> os/linux/$name"
            fi
        done
    fi
fi

echo ""
echo "Symlink creation complete!"
