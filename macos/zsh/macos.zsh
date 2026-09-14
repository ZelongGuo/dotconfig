# -------------------------------------------------------------------
# --- macOS Specific Configuration ---
# This file is loaded only on macOS systems
# -------------------------------------------------------------------

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
eval "$(/opt/homebrew/bin/brew shellenv)"

# # -------------------------------------------------------------------
# # --- GMT ---
# # NOTE: once you change the gmt version using gmtswitch, you should refresh the terminal or source ~/.zshrc to reset the GS_LIB
# # for more information, see
# # https://docs.gmt-china.org/latest/module/gmtswitch/
# # https://docs.gmt-china.org/latest/install/macOS/#gmt
# # NOTE: Moved AFTER brew shellenv to ensure GMT paths take precedence
# export GMTHOME=$HOME/this_gmt
# # export GMTHOME=/Applications/GMT-6.4.0.app/Contents/Resources
# export PATH=${GMTHOME}/bin:${PATH}
# export PROJ_LIB=$GMTHOME/share/proj
# GMT_VERSION=$(gmt --version)

# # If using pygmt (it has it own GS_LIB), it may link to following GS_LIB which would cause error
# if [[ "$GMT_VERSION" == "6.2.0" ]]; then
# 	export GS_LIB=$GMTHOME/share/ghostscript/9.53.3/Resource/Init
# else
# 	export GS_LIB=$GMTHOME/share/ghostscript/Resource/Init
# fi
# export MAGICK_CONFIGURE_PATH=$GMTHOME/lib/GraphicsMagick/config

# # Change to USTC mirrors to avoid network issue when get access to gmt remote data like dem, but it
# # doesn't have earth_relief_01m_p data which is requird by gmt 6.5, 
# # TODO: install GMT with homebrew not conda and manual installation
# export GMT_DATA_SERVER=https://mirrors.ustc.edu.cn/gmt/data
export GMT_DATA_SERVER=https://mirrors.ustc.edu.cn/gmtdata

# -------------------------------------------------------------------
# --- CONDA ---
export conda="/Users/zelong/opt/miniconda3/etc/profile.d/conda.sh"

# -------------------------------------------------------------------
# --- Git Proxy Auto Config (optional) ---
# Only needed for GUI git clients (VS Code, Fork, Tower) launched from Finder,
# which do not inherit the shell environment. Terminal git is already covered
# by the http_proxy/https_proxy exports further down, so leave this commented
# out unless you actually use such a client.
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
# macOS system proxy instead, which is configured separately under
# System Settings > Network > Proxies.
export https_proxy=http://127.0.0.1:7892 http_proxy=http://127.0.0.1:7892

# LAN and local traffic must bypass the proxy. http_proxy is a blanket switch
# that ignores the macOS system-proxy exception list (*.local, 192.168.*, ...),
# so those exceptions have to be restated here.
# NOTE: only CIDR and suffix matching are supported -- write 192.168.0.0/16,
# NOT 192.168.*, which silently fails to match and sends LAN traffic out to
# the remote node (observed as HTTP 502 Bad Gateway).
export no_proxy=localhost,127.0.0.1,::1,192.168.0.0/16,10.0.0.0/8,172.16.0.0/12,.local
export NO_PROXY="$no_proxy"
