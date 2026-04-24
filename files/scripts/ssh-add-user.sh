#!/usr/bin/env bash
set -euo pipefail

usage(){
  echo "Usage: $0 enable|disable"
  exit 2
}

cmd=${1:-}
[ -n "$cmd" ] || usage

UNIT_PATH="$HOME/.config/systemd/user/ssh-add.service"

case "$cmd" in
  enable)
    mkdir -p "$HOME/.config/systemd/user"

    cat > "$UNIT_PATH" <<'UNIT'
[Unit]
Description=Add SSH keys to agent
After=ssh-agent.socket
Requires=ssh-agent.socket

[Service]
Type=oneshot
ExecStart=/usr/bin/ssh-add %h/.ssh/id_rsa
RemainAfterExit=yes

[Install]
WantedBy=default.target
UNIT

    echo "▶ Reloading systemd user daemon and enabling service..."
    systemctl --user daemon-reload
    systemctl --user enable --now ssh-add.service

    echo "✅ ssh-add.service enabled and started."
    ;;
  disable)
    echo "▶ Disabling ssh-add.service"
    systemctl --user disable --now ssh-add.service || true

    if command -v ssh-add >/dev/null 2>&1; then
      echo "▶ Removing all identities from ssh-agent"
      ssh-add -D || true
    fi

    echo "▶ Removing unit file"
    rm -f "$UNIT_PATH"
    systemctl --user daemon-reload || true

    echo "✅ ssh-add.service disabled and unit removed."
    ;;
  *)
    usage
    ;;
esac
