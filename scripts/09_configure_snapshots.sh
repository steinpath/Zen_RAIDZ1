#!/bin/bash
source ./build.conf
log_file="$LOG_DIR/08_configure_snapshots.log"
mkdir -p "$(dirname "$log_file")"
exec > >(tee -a "$log_file") 2>&1

echo "[*] Installing and configuring Sanoid..."

# Placeholder: assumes apt install and config templates
echo "[template_production]" > /etc/sanoid/sanoid.conf
echo "$SANOID_TEMPLATES" >> /etc/sanoid/sanoid.conf

for policy in "${SANOID_POLICIES[@]}"; do
  IFS=':' read -r dataset template <<< "$policy"
  echo "[$dataset]" >> /etc/sanoid/sanoid.conf
  echo "use_template = $template" >> /etc/sanoid/sanoid.conf
done
