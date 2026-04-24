#!/bin/bash

set -ouex pipefail

### Install packages


# Microsoft Edge key and repo desc
rpm --import https://packages.microsoft.com/keys/microsoft.asc
curl -fsSL https://packages.microsoft.com/yumrepos/edge/config.repo -o /etc/yum.repos.d/microsoft-edge.repo

# this installs edge and onedrive
dnf5 install -y microsoft-edge-stable --setopt=tsflags=noscripts
dnf5 install -y onedrive

# edge as default browser 
mkdir -p /etc/xdg

cat > /etc/xdg/mimeapps.list <<'EOF'
[Default Applications]
x-scheme-handler/http=microsoft-edge.desktop
x-scheme-handler/https=microsoft-edge.desktop
text/html=microsoft-edge.desktop
EOF

# Manually run post-install tasks since tsflags=noscripts disables scripts
# Install icons
for icon in product_logo_16.png product_logo_24.png product_logo_32.png product_logo_48.png product_logo_64.png product_logo_128.png product_logo_256.png; do
  size="$(echo ${icon} | sed 's/[^0-9]//g')"
  xdg-icon-resource install --size "${size}" "/opt/microsoft/msedge/${icon}" "microsoft-edge" || true
done

# Update desktop database
update-desktop-database > /dev/null 2>&1 || true

dnf5 clean all

### Install ujust recipes and helper scripts
install -Dm0644 /ctx/files/ujust/onedrive.just /usr/share/ublue-os/just/onedrive.just
# Install custom ujust entry to import optional recipes (60-custom.just)
install -Dm0644 /ctx/files/ujust/60-custom.just /usr/share/ublue-os/just/60-custom.just
# Install helper scripts for ujust recipes
install -Dm0755 /ctx/files/scripts/ssh-add-user.sh /usr/share/ublue-os/just/scripts/ssh-add-user.sh
install -Dm0755 /ctx/files/scripts/onedrive.sh /usr/share/ublue-os/just/scripts/onedrive.sh
install -Dm0755 /ctx/files/scripts/aws-smp-install.sh /usr/share/ublue-os/just/scripts/aws-smp-install.sh