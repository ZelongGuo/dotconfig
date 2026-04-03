#!/usr/bin/bash

pkill -x polybar || true
sleep 2

for m in $(xrandr --query | awk '/ connected/{print $1}'); do
    MONITOR=$m polybar --reload main &
done
