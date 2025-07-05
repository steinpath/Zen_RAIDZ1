#!/bin/bash
source ./build.conf
log_file="$LOG_DIR/02_create_disks.log"
mkdir -p "$(dirname "$log_file")"
exec > >(tee -a "$log_file") 2>&1

echo "[*] Creating disk images..."

mkdir -p "$DISK_PATH"
for i in $(seq 0 $((DISK_COUNT - 1))); do
  disk_img="${DISK_PATH}/${DISK_PREFIX}${i}.img"
  echo "[*] Creating $disk_img of size $DISK_SIZE"
  qemu-img create -f $DISK_TYPE "$disk_img" "$DISK_SIZE" || {
    echo "❌ Failed to create $disk_img"
    exit 1
  }
done
