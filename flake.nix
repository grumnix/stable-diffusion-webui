{
  description = "AUTOMATIC1111 - Stable Diffusion WebUI";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.11";
    flake-utils.url = "github:numtide/flake-utils";

    pypi-deps-db = {
      url = "github:DavHau/pypi-deps-db";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.mach-nix.follows = "mach-nix";
    };

    mach-nix = {
      url = "github:DavHau/mach-nix/3.5.0";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
      inputs.pypi-deps-db.follows = "pypi-deps-db";
    };

    stable_diffusion_webui_src = {
      url = "github:AUTOMATIC1111/stable-diffusion-webui";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, flake-utils, mach-nix, stable_diffusion_webui_src, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        pythonEnv = mach-nix.lib."${system}".mkPython {
          requirements = builtins.replaceStrings
            ["gradio==3.23"
             ]
            ["gradio"
             ]
            (builtins.readFile "${stable_diffusion_webui_src}/requirements.txt");

          packagesExtra = [
          ];
        };
      in {
        devShells = rec {
          default = pkgs.mkShell {
            packages = [ pkgs.gnumake ];
            inputsFrom = [ pythonEnv ];
            shellHook = ''
              echo "Development Shell for stable-diffusion-webui";
              export FOO=134234;
            '';
          };
        };

#       packages = rec {
#         default = rembg;
#         rembg = mach-nix.lib.${system}.buildPythonPackage {
#           src = rembg_src;

#           postPatch = ''
# #            substituteInPlace setup.py \
# #              --replace '"opencv-python-headless>=4.6.0.66",' \
# #                         ""
#           '';

# #          requirements = builtins.replaceStrings
# #            ["opencv-python-headless==4.6.0.66"
# #             "fastapi==0.87.0"]
# #            ["opencv"
# #             "fastapi"]
# #            (builtins.readFile "${rembg_src}/requirements.txt");
#         };
#      };
    }
  );
}
