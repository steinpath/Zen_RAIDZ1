#!/bin/bash
source ./build.conf
log_file="$LOG_DIR/06_install_bootloaders.log"
mkdir -p "$(dirname "$log_file")"
exec > >(tee -a "$log_file") 2>&1

echo "[*] Installing bootloaders: ZFSBootMenu and rEFInd"

TARGET="${BUILD_DIR}/target"

# Mount essential filesystems
echo "[*] Mounting virtual filesystems for chroot"
mount --rbind /dev "$TARGET/dev"
mount --rbind /proc "$TARGET/proc"
mount --rbind /sys "$TARGET/sys"

# Copy resolv.conf for network
cp /etc/resolv.conf "$TARGET/etc/"

# Install base packages in chroot
chroot "$TARGET" /bin/bash <<EOF
set -e
echo "[*] Inside chroot - installing packages..."
apt update
apt install -y zfsbootmenu refind grub-efi-amd64 shim-signed efibootmgr zfs-initramfs
EOF

# Install rEFInd and ZFSBootMenu into EFI
mkdir -p "$TARGET/boot/efi/EFI/BOOT"
cp "$TARGET/usr/lib/refind/refind_x64.efi" "$TARGET/boot/efi/EFI/BOOT/BOOTX64.EFI"

# Placeholder for adding EFI entry (manual step may be needed in QEMU)
echo "[*] Bootloaders installed. EFI image should be verified manually in QEMU or with efibootmgr."
