#!/bin/bash
source ./build.conf
log_file="$LOG_DIR/04_create_datasets.log"
mkdir -p "$(dirname "$log_file")"
exec > >(tee -a "$log_file") 2>&1

echo "[*] Creating ZFS datasets..."

for entry in "${DATASETS[@]}"; do
  IFS=':' read -r ds mp opts <<< "$entry"
  cmd="zfs create"
  [[ -n "$opts" ]] && cmd+=" -o $opts"
  cmd+=" -o mountpoint=$mp $ds"
  echo "[*] $cmd"
  eval "$cmd" || {
    echo "❌ Failed to create dataset $ds"
    exit 1
  }
done
