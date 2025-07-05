#!/bin/bash
source ./build.conf
log_file="$LOG_DIR/01_prepare_environment.log"
mkdir -p "$(dirname "$log_file")"
exec > >(tee -a "$log_file") 2>&1

echo "[*] Preparing environment..."

if [[ "$ENABLE_KERNEL_PROTECTION" == "true" ]]; then
  echo "[*] Applying apt-mark hold on kernel packages"
  for pkg in "${KERNEL_HOLD_PACKAGES[@]}"; do
    apt-mark hold "$pkg" || echo "⚠️ Failed to hold $pkg"
  done
fi

installed_zfs=$(modinfo zfs 2>/dev/null | awk '/^version:/ {print $2}')
if [[ -z "$installed_zfs" ]]; then
  echo "🛑 ZFS module not found!"
  exit 1
elif [[ "$installed_zfs" < "$ZFS_MIN_VERSION" ]]; then
  echo "🛑 ZFS version $installed_zfs < required $ZFS_MIN_VERSION"
  exit 1
else
  echo "[*] ZFS version OK: $installed_zfs"
fi
