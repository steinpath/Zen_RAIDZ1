#!/bin/bash
source ./build.conf
log_file="$LOG_DIR/03_create_pool.log"
mkdir -p "$(dirname "$log_file")"
exec > >(tee -a "$log_file") 2>&1

echo "[*] Creating ZFS pool $POOL_NAME..."

DISK_LIST=""
for i in $(seq 0 $((DISK_COUNT - 1))); do
  DISK_LIST+=" ${DISK_PATH}/${DISK_PREFIX}${i}.img"
done

zpool create -f -o ashift=${POOL_ASHIFT} -O mountpoint=none -O compression=lz4 \
  $POOL_NAME $POOL_TYPE $DISK_LIST || {
  echo "❌ Failed to create ZFS pool"
  exit 1
}
