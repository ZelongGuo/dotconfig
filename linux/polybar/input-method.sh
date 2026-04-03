#!/usr/bin/env bash

status=$(fcitx5-remote)

case "$status" in
  0)
    echo "?"
    ;;
  1)
    echo "EN"
    ;;
  2)
    echo "中"
    ;;
  *)
    echo "?"
    ;;
esac
