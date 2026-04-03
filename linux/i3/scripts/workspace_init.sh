#!/usr/bin/bash
set -e

PRIMARY="HDMI-0"
SECONDARY="HDMI-1-2"

WS1="1"
WS2="2"
WS3="3"
WS4="4"
WS5="5"
WS6="6"
WST="11:T"

if xrandr --query | grep "^$SECONDARY connected" >/dev/null 2>&1; then
    i3-msg "workspace $WS1; move workspace to output $PRIMARY"
    i3-msg "workspace $WS2; move workspace to output $PRIMARY"
    i3-msg "workspace $WS3; move workspace to output $PRIMARY"
    i3-msg "workspace $WS4; move workspace to output $SECONDARY"
    i3-msg "workspace $WS5; move workspace to output $SECONDARY"
    i3-msg "workspace $WS6; move workspace to output $SECONDARY"
    i3-msg "workspace \"$WST\"; move workspace to output $SECONDARY"
    i3-msg "workspace $WS1"
else
    for ws in "$WS1" "$WS2" "$WS3" "$WS4" "$WS5" "$WS6"; do
        i3-msg "workspace $ws; move workspace to output $PRIMARY"
    done
    i3-msg "workspace \"$WST\"; move workspace to output $PRIMARY"
    i3-msg "workspace $WS1"
fi
