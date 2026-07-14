#!/usr/bin/env bash

MOUNT_POINT="$HOME/mnt/mac"
REMOTE="mac-lan:/Users/zelong"
LOCK_FILE="${XDG_RUNTIME_DIR:-/tmp}/mount-mac.lock"

notify() {
    command -v notify-send >/dev/null 2>&1 &&
        notify-send -i "$1" -t 2500 "$2" "$3"
}

mkdir -p "$MOUNT_POINT"

exec 9>"$LOCK_FILE"
if ! flock -n 9; then
    notify dialog-information "SSHFS" "A mount operation is already running"
    exit 0
fi

if mountpoint -q "$MOUNT_POINT"; then
    notify network-server "SSHFS" "Mac is already mounted"
    exit 0
fi

if sshfs "$REMOTE" "$MOUNT_POINT" \
    -o reconnect \
    -o BatchMode=yes \
    -o ConnectTimeout=3 \
    -o ServerAliveInterval=15 \
    -o ServerAliveCountMax=3 \
    -o follow_symlinks \
    -o idmap=user \
    -o cache=yes
then
    if mountpoint -q "$MOUNT_POINT"; then
        notify network-server "SSHFS · LAN" "Mac mounted at $MOUNT_POINT"
        exit 0
    fi
fi

if mountpoint -q "$MOUNT_POINT"; then
    if command -v fusermount3 >/dev/null 2>&1; then
        fusermount3 -u "$MOUNT_POINT" 2>/dev/null
    elif command -v fusermount >/dev/null 2>&1; then
        fusermount -u "$MOUNT_POINT" 2>/dev/null
    fi
fi

notify dialog-error "SSHFS · Error" "Could not mount Mac through mac-lan"
exit 1
