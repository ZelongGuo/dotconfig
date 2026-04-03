#!/usr/bin/bash

MOUNT_POINT="$HOME/mnt/mac"
REMOTE="mac:/Users/zelong"

mkdir -p "$MOUNT_POINT"

if mount | grep -q "$MOUNT_POINT"; then
    echo "Already mounted"
    exit 0
fi

echo "Mounting mac..."

sshfs "$REMOTE" "$MOUNT_POINT" \
    -o reconnect \
    -o ServerAliveInterval=15 \
    -o ServerAliveCountMax=3 \
    -o follow_symlinks \
    -o idmap=user \
    -o cache=yes

echo "Done"
