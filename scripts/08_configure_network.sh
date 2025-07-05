#!/bin/bash
source ./build.conf
log_file="$LOG_DIR/07_configure_network.log"
mkdir -p "$(dirname "$log_file")"
exec > >(tee -a "$log_file") 2>&1

echo "[*] Configuring network using $NETWORK_CONFIG"

netplan_path="${BUILD_DIR}/target/etc/netplan"
mkdir -p "$netplan_path"
echo "$NETPLAN_CONFIG" > "$netplan_path/01-netplan.yaml"
