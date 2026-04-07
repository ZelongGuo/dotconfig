#!/usr/bin/bash
set -e

PRIMARY=$(xrandr | grep " connected" | awk 'NR==1{print $1}')
SECONDARY=$(xrandr | grep " connected" | awk 'NR==2{print $1}')

# Exit if no monitor is detected (should not normally happen)
[ -z "$PRIMARY" ] && exit 1

if [ -n "$SECONDARY" ]; then
    i3-msg "
    workspace 1; move workspace to output $PRIMARY;
    workspace 2; move workspace to output $PRIMARY;
    workspace 3; move workspace to output $PRIMARY;
    workspace 4; move workspace to output $PRIMARY;
    workspace 5; move workspace to output $PRIMARY;
    workspace 6; move workspace to output $SECONDARY;
    workspace 7; move workspace to output $SECONDARY;
    workspace 8; move workspace to output $SECONDARY;
    workspace 9; move workspace to output $SECONDARY;
    workspace 0; move workspace to output $SECONDARY;
    workspace \"11:T\"; move workspace to output $SECONDARY;
    workspace 1
    "
else
    i3-msg "
    workspace 1; move workspace to output $PRIMARY;
    workspace 2; move workspace to output $PRIMARY;
    workspace 3; move workspace to output $PRIMARY;
    workspace 4; move workspace to output $PRIMARY;
    workspace 5; move workspace to output $PRIMARY;
    workspace 6; move workspace to output $PRIMARY;
    workspace 7; move workspace to output $PRIMARY;
    workspace 8; move workspace to output $PRIMARY;
    workspace 9; move workspace to output $PRIMARY;
    workspace 0; move workspace to output $PRIMARY;
    workspace \"11:T\"; move workspace to output $PRIMARY;
    workspace 1
    "
fi
