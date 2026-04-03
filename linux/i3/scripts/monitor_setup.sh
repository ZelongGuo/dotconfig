#!/usr/bin/bash
set -e

# Get the monitors' name by xrandr command
PRIMARY="HDMI-0"
SECONDARY="HDMI-1-2"

is_connected() {
    xrandr --query | grep "^$1 connected" >/dev/null 2>&1
}

# Use the default 4K resolution, but the fonts would be rather small than 2K
setup_dual() {
    xrandr \
        --output "$PRIMARY" --primary --mode 2560x1440 --pos 0x0 \
        --output "$SECONDARY" --mode 3840x2160 --right-of "$PRIMARY"
}

# # Change scales for 2K and 4K monitors for showing similar size text, if we do so, the resolution of
# # the 4K would even worse than 2K
# setup_dual() {
#     xrandr \
#         --output "$PRIMARY" --primary --mode 2560x1440 --pos 0x0 \
#         --output "$SECONDARY" --mode 3840x2160 --scale 0.75x0.75 --right-of "$PRIMARY"
# }

setup_single() {
    xrandr \
        --output "$SECONDARY" --off \
        --output "$PRIMARY" --primary --mode 2560x1440 --pos 0x0
}

if is_connected "$SECONDARY"; then
    setup_dual
else
    setup_single
fi

