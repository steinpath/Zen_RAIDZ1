#!/bin/bash
source ./build.conf
log_file="$LOG_DIR/05_install_ubuntu.log"
mkdir -p "$(dirname "$log_file")"
exec > >(tee -a "$log_file") 2>&1

echo "[*] Installing Ubuntu base system with debootstrap..."

target="${BUILD_DIR}/target"
mkdir -p "$target"

debootstrap --arch=$ARCH "$UBUNTU_CODENAME" "$target" "$UBUNTU_MIRROR" || {
  echo "❌ debootstrap failed"
  exit 1
}

echo "[*] Ubuntu base installed in $target"
