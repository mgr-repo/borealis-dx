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
dnf5 install -y microsoft-edge-stable onedrive

# edge as default browser 
xdg-settings set default-web-browser microsoft-edge.desktop || true

TMPDIR="$(mktemp -d)"
cd "$TMPDIR"

############################
# AWS CLI v2
############################

curl -fsSL \
  "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" \
  -o awscliv2.zip

dnf install -y unzip
unzip -q awscliv2.zip

./aws/install \
  --bin-dir /usr/local/bin \
  --install-dir /usr/local/aws-cli \
  --update

############################
# Session Manager Plugin
############################

curl -fsSL \
  "https://s3.amazonaws.com/session-manager-downloads/plugin/latest/linux_x86_64/session-manager-plugin.rpm" \
  -o session-manager-plugin.rpm

dnf install -y ./session-manager-plugin.rpm

############################
# Cleanup
############################

cd /
rm -rf "$TMPDIR"
dnf clean all


install -Dm0644 files/ujust/onedrive.just /usr/share/ujust/onedrive