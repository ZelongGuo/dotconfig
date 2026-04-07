#!/usr/bin/bash
fusermount -u ~/mnt/mac 2>/dev/null || umount ~/mnt/mac
notify-send -i network-server -t 2000 "SSHFS" "Unmounted."
