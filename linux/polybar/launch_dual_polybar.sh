#!/usr/bin/bash

pkill -x polybar || true
sleep 1

primary_monitor=$(xrandr --query | awk '/ connected primary/{print $1; exit}')
if [[ -z "$primary_monitor" ]]; then
    primary_monitor=$(xrandr --query | awk '/ connected/{print $1; exit}')
fi

for monitor_name in $(xrandr --query | awk '/ connected/{print $1}'); do
    if [[ "$monitor_name" == "$primary_monitor" ]]; then
        MONITOR="$monitor_name" polybar --reload main-tray &
    else
        MONITOR="$monitor_name" polybar --reload main &
    fi
done
