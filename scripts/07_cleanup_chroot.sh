#!/bin/bash
source ./build.conf
log_file="$LOG_DIR/cleanup_chroot.log"
mkdir -p "$(dirname "$log_file")"
exec > >(tee -a "$log_file") 2>&1

TARGET="${BUILD_DIR}/target"
echo "[*] Cleaning up chroot environment..."

umount -l "$TARGET/dev/pts" 2>/dev/null
umount -l "$TARGET/dev" 2>/dev/null
umount -l "$TARGET/proc" 2>/dev/null
umount -l "$TARGET/sys" 2>/dev/null

echo "[*] Chroot environment cleaned up."
