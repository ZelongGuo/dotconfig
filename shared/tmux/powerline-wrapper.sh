#!/bin/bash
# Wrapper for tmux powerline to ensure correct path
SCRIPT_DIR="$(dirname "$0")"
export TMUX_POWERLINE_DIR_HOME="$SCRIPT_DIR/tmux-powerline"
bash "$TMUX_POWERLINE_DIR_HOME/powerline.sh" "$@"
