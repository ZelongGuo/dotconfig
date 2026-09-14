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
export conda="/data/opt/miniconda/etc/profile.d/conda.sh"

# -------------------------------------------------------------------
# --- TEXLIVE ---
export PATH=/usr/local/texlive/2026/bin/x86_64-linux:$PATH

# -------------------------------------------------------------------
# --- GMT (if used on Linux) ---
# Uncomment and adjust the path for your Linux system
# export GMTHOME=$HOME/this_gmt
# export PATH=${GMTHOME}/bin:${PATH}
# export PROJ_LIB=$GMTHOME/share/proj

# -------------------------------------------------------------------
# --- Git Proxy Auto Config (optional) ---
# Only needed for GUI git clients that do not inherit the shell environment.
# Terminal git is already covered by the http_proxy/https_proxy exports further
# down, so leave this commented out unless you actually use such a client.
# Auto-detects whether the proxy is running and configures git accordingly.

# setup_git_proxy() {
#     # The local port is 14122
#     local local_port=14122
#     # The default clash port is 7890
#     local clash_port=7890

#     if lsof -i tcp:$local_port -sTCP:LISTEN >/dev/null 2>&1; then
#         git config --global http.proxy "http://127.0.0.1:$clash_port"
#         git config --global https.proxy "http://127.0.0.1:$clash_port"
#         # echo "[Git Proxy] enabled! (http://127.0.0.1:$clash_port)"
#     else
#         git config --global --unset http.proxy >/dev/null 2>&1
#         git config --global --unset https.proxy >/dev/null 2>&1
#         # echo "[Git Proxy] disabled!（clash is not running now）"
#     fi
# }

# setup_git_proxy

# -------------------------------------------------------------------
# --- Proxy Config (BoostNet / Clash / Mihomo Party) ---
# Set the port to your proxy client's mixed port:
#   BoostNet     -> 7892  (currently in use)
#   Mihomo Party -> 7890
# export https_proxy=http://127.0.0.1:7890 http_proxy=http://127.0.0.1:7890
# These env vars cover CLI tools (git, curl, codex, ...). GUI apps use the
# Linux desktop environment's system proxy settings instead.
export https_proxy=http://127.0.0.1:7892 http_proxy=http://127.0.0.1:7892

# LAN and local traffic must bypass the proxy. http_proxy is a blanket switch
# that ignores the desktop environment's system-proxy exception list, so those
# exceptions have to be restated here.
# NOTE: only CIDR and suffix matching are supported -- write 192.168.0.0/16,
# NOT 192.168.*, which silently fails to match and sends LAN traffic out to
# the remote node (observed as HTTP 502 Bad Gateway).
export no_proxy=localhost,127.0.0.1,::1,192.168.0.0/16,10.0.0.0/8,172.16.0.0/12,.local
export NO_PROXY="$no_proxy"



