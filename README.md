# Borealis DX

This repository contains a custom Universal Blue Aura DX-based distro built for testing and experimentation.
It is a fork of the Universal Blue `image-template` for bootc container images.

- Based on Universal Blue Aurora: https://github.com/ublue-os/aurora
- Built from the Universal Blue `image-template` pattern for custom bootc images
- Intended for testing, development, and experimentation with the Aurora DX stack

## About this repo

`borealis-dx` is my experimentation environment for building a custom Universal Blue Aurora DX.

This repo includes:
- `Containerfile` for defining the custom image build
- `build_files/build.sh` for install-time package additions and distro customizations
- `Justfile` for local build, image management, and VM workflows
- `disk_config/` for optional ISO and VM image generation
- GitHub Actions workflows for building, signing, and publishing the OCI image


## Getting started

1. Review `Containerfile` and `build_files/build.sh` to understand what is installed and configured.
2. Use the `Justfile` commands to build and test the image locally.
3. If you want to generate bootable media, update `disk_config/iso.toml` and run the disk build workflow.


---

## Links

- Universal Blue Aurora: https://github.com/ublue-os/aurora
- Universal Blue `image-template`: https://github.com/ublue-os/bootc
- bootc project: https://github.com/bootc-dev/bootc
