#!/bin/bash
source ./build.conf
log_file="$LOG_DIR/06_install_bootloaders.log"
mkdir -p "$(dirname "$log_file")"
exec > >(tee -a "$log_file") 2>&1

echo "[*] Installing ZFSBootMenu and rEFInd..."

# Placeholder logic — to be adapted when target chroot is mounted
echo "[*] Downloading ZFSBootMenu version $ZBM_VERSION"
echo "[*] Configuring EFI bootloader ID: $EFI_BOOTLOADER_ID"

# TODO: real installation logic within chrooted environment
