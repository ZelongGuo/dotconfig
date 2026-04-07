#!/usr/bin/bash

set -e

~/.config/i3/scripts/monitor_setup.sh

# Leave some time for arranging layout
sleep 1

~/.config/i3/scripts/workspace_init.sh

