# -------------------------------------------------------------------
# --- Linux Specific Configuration ---
# This file is loaded only on Linux systems
# -------------------------------------------------------------------

# --- HOMEBREW Tsinghua Mirrors for Domestic ---
export HOMEBREW_BREW_GIT_REMOTE="https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/brew.git"
export HOMEBREW_CORE_GIT_REMOTE="https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-core.git"
export HOMEBREW_CASK_GIT_REMOTE="https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-cask.git"
export HOMEBREW_BOTTLE_DOMAIN="https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles"

# # --- Homebrew Officials, uncomment blow if needed  ---
# export HOMEBREW_BREW_GIT_REMOTE="https://github.com/Homebrew/brew.git"
# export HOMEBREW_CORE_GIT_REMOTE="https://github.com/Homebrew/homebrew-core.git"
# export HOMEBREW_CASK_GIT_REMOTE="https://github.com/Homebrew/homebrew-cask.git"
# unset HOMEBREW_BOTTLE_DOMAIN

# When you come across some failed installation about the "Bottle", you can try to
# comment the following lines or change it to other mirrors...
#export HOMEBREW_BOTTLE_DOMAIN=https://mirrors.ustc.edu.cn/homebrew-bottles/bottles

# Include the all apps installed by homebrew pathes to env virables PATH
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv zsh)"

# -------------------------------------------------------------------
# --- CONDA ---
# Uncomment and adjust the path for your Linux system
# export conda="$HOME/miniconda3/etc/profile.d/conda.sh"

# -------------------------------------------------------------------
# --- GMT (if used on Linux) ---
# Uncomment and adjust the path for your Linux system
# export GMTHOME=$HOME/this_gmt
# export PATH=${GMTHOME}/bin:${PATH}
# export PROJ_LIB=$GMTHOME/share/proj

# -------------------------------------------------------------------
# --- Proxy Configuration (if needed) ---
# Uncomment and adjust for your proxy setup
# export https_proxy=http://127.0.0.1:7890
# export http_proxy=http://127.0.0.1:7890


# -------------------------------------------------------------------
# --- Git Proxy Auto Config (Mihomo Party / Clash) ---
# Auto test if clash (mihomo party) is running, if so, configuring the proxy for git

setup_git_proxy() {
    # The local port is 14122
    local local_port=14122
    # The default clash port is 7890
    local clash_port=7890

    if lsof -i tcp:$local_port -sTCP:LISTEN >/dev/null 2>&1; then
        git config --global http.proxy "http://127.0.0.1:$clash_port"
        git config --global https.proxy "http://127.0.0.1:$clash_port"
        # echo "[Git Proxy] enabled! (http://127.0.0.1:$clash_port)"
    else
        git config --global --unset http.proxy >/dev/null 2>&1
        git config --global --unset https.proxy >/dev/null 2>&1
        # echo "[Git Proxy] disabled!（clash is not running now）"
    fi
}

setup_git_proxy

