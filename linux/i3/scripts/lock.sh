#!/bin/bash

scrot /tmp/screen.png

# magick /tmp/screen.png -blur /tmp/lock.png
magick /tmp/screen.png -blur 0x8 /tmp/lock.png

# i3lock -i /tmp/lock.png 

i3lock -i /tmp/lock.png \
  --inside-color=00000088 \
  --ring-color=88c0d0 \
  --line-color=00000000 \
  --keyhl-color=00ff00ff \
  --bshl-color=bf616a \
  --separator-color=00000000 \
  --insidever-color=00000088 \
  --insidewrong-color=00000088 \
  --ringver-color=a3be8c \
  --ringwrong-color=bf616a \
  --ind-pos="x+w/2:y+h/2" \
  --radius=120 \
  --ring-width=8 \
  --clock \
  --indicator \
  --time-color=eceff4 \
  --date-color=d8dee9 \
  --time-str="%H:%M:%S" \
  --date-str="%Y-%m-%d" \
  --verif-text="Verifying..." \
  --wrong-text="Wrong!" \
  --noinput-text="" \
  --lock-text="Locked" \
  --screen 1 \
  --blur 7 \
  # --fade-in 0.2

