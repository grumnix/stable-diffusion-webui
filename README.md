Stable Diffusion WebUI for Nix
==============================

Nix development shell for [Stable Diffusion
WebUI](https://github.com/AUTOMATIC1111/stable-diffusion-webui).
Tested on AMD GPU.

Based on:

* https://github.com/virchau13/automatic1111-webui-nix

Usage
-----

Enable flakes by editing either `~/.config/nix/nix.conf` or `/etc/nix/nix.conf` and add

    experimental-features = nix-command flakes

Download the Nix flake:

    git clone https://github.com/grumnix/stable-diffusion-webui.git

Enter the development shell:

    cd stable-diffusion-webui/
    nix develop .

Download and run stable-diffusion-webui:

    git clone https://github.com/AUTOMATIC1111/stable-diffusion-webui.git
    cd stable-diffusion-webui/
    ./webui.sh --skip-torch-cuda-test
