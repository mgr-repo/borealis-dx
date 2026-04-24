# Add your SSH key on startup to ssh-agent.  
[group('BI helpers')]
ssh-key-agent-enable:
    #!/usr/bin/bash
    echo ""
    echo "🔐 Install and enable ssh-add systemd user service"
    echo ""

    /usr/share/ublue-os/just/scripts/ssh-add-user.sh enable

    echo ""
    echo "You can verify with: systemctl --user status ssh-add.service"
    echo ""

[group('BI helpers')]
ssh-key-agent-disable:
    #!/usr/bin/bash
    echo ""
    echo "🧹 Disable ssh-add service and remove keys"
    echo ""

    /usr/share/ublue-os/just/scripts/ssh-add-user.sh disable

    echo ""
    echo "Done."
    echo ""
