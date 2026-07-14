#!/usr/bin/env bash

MOUNT_POINT="$HOME/mnt/mac"

notify() {
    command -v notify-send >/dev/null 2>&1 &&
        notify-send -i "$1" -t 2500 "$2" "$3"
}

if ! mountpoint -q "$MOUNT_POINT"; then
    notify dialog-information "SSHFS" "Mac is not mounted"
    exit 0
fi

if command -v fusermount3 >/dev/null 2>&1; then
    fusermount3 -u "$MOUNT_POINT"
elif command -v fusermount >/dev/null 2>&1; then
    fusermount -u "$MOUNT_POINT"
else
    notify dialog-error "SSHFS · Error" "No FUSE unmount command is installed"
    exit 1
fi

if mountpoint -q "$MOUNT_POINT"; then
    notify dialog-error "SSHFS · Error" "Failed to unmount $MOUNT_POINT"
    exit 1
fi

notify network-server "SSHFS" "Mac unmounted"
