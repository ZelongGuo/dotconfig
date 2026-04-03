#!/usr/bin/env bash

set -e

~/.config/i3/scripts/monitor_setup.sh

# Leave some time for arranging layout
sleep 2

~/.config/i3/scripts/workspace_init.sh
~/.config/polybar/launch_dual_polybar.sh

