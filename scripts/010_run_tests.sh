#!/bin/bash
source ./build.conf
log_file="$LOG_DIR/09_run_tests.log"
mkdir -p "$(dirname "$log_file")"
exec > >(tee -a "$log_file") 2>&1

echo "[*] Boot testing in QEMU..."

qemu-system-x86_64 \
  -m "$QEMU_MEMORY" \
  -smp "$QEMU_CPUS" \
  -enable-kvm \
  -bios /usr/share/OVMF/OVMF_CODE.fd \
  -drive file="${DISK_PATH}/${DISK_PREFIX}0.img",format=raw,if=virtio \
  -net user,hostfwd=tcp::${TEST_SSH_PORT}-:22 -net nic \
  -nographic || echo "⚠️ QEMU test failed"
