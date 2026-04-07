#!/usr/bin/bash
set -e

# Read the first two connected outputs from xrandr
PRIMARY=$(xrandr | grep " connected" | awk 'NR==1{print $1}')
SECONDARY=$(xrandr | grep " connected" | awk 'NR==2{print $1}')

# Exit if no monitor is detected (should not normally happen)
[ -z "$PRIMARY" ] && exit 1

# Configure dual monitor setup
setup_dual() {
    xrandr \
        --output "$PRIMARY" --primary --mode 2560x1440 --pos 0x0 \
        --output "$SECONDARY" --auto --right-of "$PRIMARY"
}

# Change scales for 2K and 4K monitors for showing similar size text, if we do so, the resolution of
# the 4K would even worse than 2K, use xrandr checking the resolution
# setup_dual() {
#     xrandr \
#         --output "$PRIMARY" --primary --mode 2560x1440 --pos 0x0 \
#         --output "$SECONDARY" --mode 3840x2160 --scale 0.75x0.75 --right-of "$PRIMARY"
# }

setup_single() {
    xrandr \
        --output "$PRIMARY" --primary --auto --pos 0x0
}

# If a second monitor exists → dual screen
# Otherwise → single screen
if [ -n "$SECONDARY" ]; then
    setup_dual
else
    setup_single
fi
