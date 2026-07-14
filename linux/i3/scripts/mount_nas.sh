#!/usr/bin/env bash

MOUNT_POINT="$HOME/mnt/nas/home"
LOCK_FILE="${XDG_RUNTIME_DIR:-/tmp}/mount-nas.lock"

notify() {
    command -v notify-send >/dev/null 2>&1 &&
        notify-send -i "$1" -t 2500 "$2" "$3"
}

mkdir -p "$MOUNT_POINT"
exec 9>"$LOCK_FILE"

if ! flock -n 9; then
    notify dialog-information "NAS" "A mount operation is already running"
    exit 0
fi

if mountpoint -q "$MOUNT_POINT"; then
    notify network-server "NAS · SMB" "NAS home is already mounted"
    exit 0
fi

if /usr/bin/mount "$MOUNT_POINT" && mountpoint -q "$MOUNT_POINT"; then
    notify network-server "NAS · SMB" "NAS home mounted at $MOUNT_POINT"
    exit 0
fi

notify dialog-error "NAS · Error" "Could not mount NAS home"
exit 1
