#!/bin/bash

set -ouex pipefail

### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/43/x86_64/repoview/index.html&protocol=https&redirect=1


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

TMPDIR="$(mktemp -d)"
cd "$TMPDIR"

############################
# AWS CLI v2
############################

curl -fsSL \
  "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" \
  -o awscliv2.zip

dnf5 install -y unzip
unzip -q awscliv2.zip

./aws/install \
  --bin-dir /usr/bin \
  --install-dir /usr/lib/aws-cli \
  --update

############################
# Session Manager Plugin
############################

# curl -fsSL \
#   https://s3.amazonaws.com/session-manager-downloads/plugin/latest/linux_64bit/session-manager-plugin.rpm \
#   -o session-manager-plugin.rpm

# # Extract RPM payload only (do NOT install)
# rpm2cpio session-manager-plugin.rpm | cpio -idmv

# # Install files explicitly
# cp -a usr/local/sessionmanagerplugin /usr/local/
# install -Dm0755 usr/bin/session-manager-plugin /usr/bin/session-manager-plugin
# install -Dm0644 \
#   usr/lib/systemd/system/session-manager-plugin.service \
#   /usr/lib/systemd/system/session-manager-plugin.service

# # Ensure runtime state directory exists
# mkdir -p /var/lib/amazon/sessionmanagerplugin


############################
# Cleanup
############################

cd /
rm -rf "$TMPDIR"
dnf5 clean all


install -Dm0644 /ctx/files/ujust/onedrive.just /usr/share/ujust/onedrive