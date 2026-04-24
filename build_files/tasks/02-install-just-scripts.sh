### Install ujust recipes and helper scripts
install -Dm0644 /ctx/files/ujust/onedrive.just /usr/share/ublue-os/just/onedrive.just
install -Dm0644 /ctx/files/ujust/aws-smp.just /usr/share/ublue-os/just/aws-smp.just
install -Dm0644 /ctx/files/ujust/ssh-key-agent.just /usr/share/ublue-os/just/ssh-key-agent.just


# Install custom ujust entry to import optional recipes (60-custom.just)
install -Dm0644 /ctx/files/ujust/60-custom.just /usr/share/ublue-os/just/60-custom.just
# Install helper scripts for ujust recipes
install -Dm0755 /ctx/files/scripts/ssh-add-user.sh /usr/share/ublue-os/just/scripts/ssh-add-user.sh
install -Dm0755 /ctx/files/scripts/onedrive.sh /usr/share/ublue-os/just/scripts/onedrive.sh
install -Dm0755 /ctx/files/scripts/aws-smp-install.sh /usr/share/ublue-os/just/scripts/aws-smp-install.sh