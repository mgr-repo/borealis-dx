#!/usr/bin/env bash
set -euo pipefail

usage(){
  echo "Usage: $0 auth|service"
  exit 2
}

cmd=${1:-}
[ -n "$cmd" ] || usage

case "$cmd" in
  auth)
    echo ""
    echo "🔐 OneDrive (re)authentication"
    echo ""
    echo "A browser window will open. Log in with your Microsoft account to authorize OneDrive."
    echo ""

    onedrive --reauth

    echo ""
    echo "✅ Authentication finished."
    ;;
  service)
    echo ""
    echo "⚙ OneDrive service setup"
    echo ""

    if systemctl --user is-enabled onedrive.service >/dev/null 2>&1; then
      echo "ℹ OneDrive service is already enabled."
    else
      echo "▶ Enabling OneDrive user service..."
      systemctl --user enable onedrive.service
    fi

    echo "▶ Starting OneDrive user service..."
    systemctl --user start onedrive.service || true

    echo ""
    echo "✅ OneDrive sync service is running."
    echo ""
    echo "📊 Status:"
    systemctl --user status onedrive.service --no-pager || true
    ;;
  *)
    usage
    ;;
esac
