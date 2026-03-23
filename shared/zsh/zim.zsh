# ===================================================================
# Plugin Configuration
# ===================================================================

# --------------------------- Zim Framework ---------------------------
# Zim is a Zsh configuration framework with modules and themes
# https://github.com/zimfw/zimfw

export PLUG_DIR=$HOME/.zim

# Initialize Zim if not already installed
if [[ ! -d $PLUG_DIR ]]; then
    # Install Zim if missing
    # curl -fsSL https://raw.githubusercontent.com/zimfw/install/master/install.zsh | zsh
    echo "Zim not found. Install it with:"
    echo "  curl -fsSL https://raw.githubusercontent.com/zimfw/install/master/install.zsh | zsh"
fi

# Zim will be initialized by ~/.zimrc if installed
# The ~/.zimrc symlink is created by symlink.sh during bootstrap
