{ pkgs
}:
let
in
pkgs.mkShell rec {
  name = "stable-diffusion-webui";
  buildInputs = with pkgs; [
    autoconf
    binutils
    curl
    freeglut
    git # The program instantly crashes if git is not present, even if everything is already downloaded
    gitRepo
    glib
    gnumake
    gnupg
    gperf
    libGL
    libGLU
    m4
    ncurses5
    pkg-config
    procps
    python310
    stdenv.cc
    stdenv.cc.cc.lib
    unzip
    util-linux
    xorg.libX11
    xorg.libXext
    xorg.libXi
    xorg.libXmu
    xorg.libXrandr
    xorg.libXv
    zlib

    radeontop  # to keep track of your VRAM usage
    fontconfig # for depthmap-script plugin
    # python-fontconfig is broken, workaround:
    # source ./venv/bin/activate
    # (venv) pip install git+https://github.com/lilydjwg/python-fontconfig
  ];

  shellHook = ''
    export LD_LIBRARY_PATH="${pkgs.lib.makeLibraryPath buildInputs}"
    export PS1="\[\033[0;31m\](SD)\[\033[0m\] $PS1"

    echo "Stable Diffusion web UI for Nix"
    echo "=============================="
    echo ""
    echo "Download Stable Diffusion web UI:"
    echo "  git clone https://github.com/AUTOMATIC1111/stable-diffusion-webui.git"
    echo ""
    echo "Update Stable Diffusion web UI:"
    echo "  cd stable-diffusion-webui/"
    echo "  git pull"
    echo ""
    echo "Run Stable Diffusion web UI:"
    echo "  cd stable-diffusion-webui/"
    echo "  # add --precision full --no-half for certain AMD cards"
    echo "  ./webui.sh --skip-torch-cuda-test"
    echo ""
    echo "Enter Stable Diffusion web UI Python VEnv and installing extra packages:"
    echo "  cd stable-diffusion-webui/"
    echo "  source venv/bin/activate"
    echo "  pip install git+https://github.com/lilydjwg/python-fontconfig  # for depthmap-script"
    echo ""
  '';
}
