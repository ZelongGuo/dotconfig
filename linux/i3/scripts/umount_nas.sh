#!/usr/bin/env bash

MOUNT_POINT="$HOME/mnt/nas/home"
LOCK_FILE="${XDG_RUNTIME_DIR:-/tmp}/mount-nas.lock"

notify() {
    command -v notify-send >/dev/null 2>&1 &&
        notify-send -i "$1" -t 2500 "$2" "$3"
}

exec 9>"$LOCK_FILE"

if ! flock -n 9; then
    notify dialog-information "NAS" "A mount operation is already running"
    exit 0
fi

if ! mountpoint -q "$MOUNT_POINT"; then
    notify dialog-information "NAS · SMB" "NAS home is not mounted"
    exit 0
fi

if /usr/bin/umount "$MOUNT_POINT" && ! mountpoint -q "$MOUNT_POINT"; then
    notify network-server "NAS · SMB" "NAS home unmounted"
    exit 0
fi

notify dialog-error "NAS · Error" "Failed to unmount $MOUNT_POINT"
exit 1
