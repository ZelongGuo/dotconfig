# -------------------------------------------------------------------
# --- True Color ---
# set the terminal (iterm) to 256 xterm, only some of modern terminal emulators support true color
export TERM=xterm-256color
# tell current applications like vim and tmux that the current terminal support true color
export COLORTERM=truecolor

# -------------------------------------------------------------------
# --- NVIM SETTINGS ---
export MYNVIMRC="~/.config/nvim/init.lua"
# DO NOT LOAD DEFAULT RC, USING THE COUSTOM ONE
export RANGER_LOAD_DEFAULT_RC="false"
# change the default editor to nvim
export EDITOR=nvim

# -------------------------------------------------------------------
# --- General PATH ---
# for claude code
export PATH="$HOME/.local/bin:$PATH"
# for opencode
export PATH="$HOME/.opencode/bin:$PATH"
