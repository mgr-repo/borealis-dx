# OneDrive helpers
#
# Provides separate helpers to:
#  - Authenticate OneDrive
#  - Enable and start the OneDrive user service

@onedrive-auth:
  echo ""
  echo "🔐 OneDrive authentication"
  echo ""
  echo "A browser window will open."
  echo "Log in with your Microsoft account to authorize OneDrive."
  echo ""

  onedrive

  echo ""
  echo "✅ Authentication finished."
  echo "ℹ You can re-run this command anytime to re-authenticate."
  echo ""

@onedrive-service:
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
  systemctl --user start onedrive.service

  echo ""
  echo "✅ OneDrive sync service is running."
  echo ""
  echo "📊 Status:"
  systemctl --user status onedrive.service --no-pager