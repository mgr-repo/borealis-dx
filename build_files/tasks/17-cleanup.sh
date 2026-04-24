#!/usr/bin/bash

echo "::group:: ===17-cleanup==="

set -ouex pipefail

# Clean DNF/runtime artifacts to avoid persisting caches and lint warnings
dnf5 clean all || true
# remove runtime-only and cache artifacts created during install
rm -rf /run/dnf || true
rm -rf /var/cache/dnf || true
find /var/lib/dnf -type f -name 'countme' -delete || true

# Ensure DNF directories exist and document them for systemd tmpfiles
mkdir -p /var/lib/dnf /var/cache/dnf
cat > /etc/tmpfiles.d/dnf.conf <<'EOF'
d /var/lib/dnf 0755 root root -
d /var/cache/dnf 0755 root root -
EOF

echo "::endgroup::"
