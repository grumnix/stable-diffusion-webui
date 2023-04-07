{
  description = "AUTOMATIC1111 - Stable Diffusion WebUI";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.11";
    flake-utils.url = "github:numtide/flake-utils";

    stable_diffusion_webui_src = {
      url = "github:AUTOMATIC1111/stable-diffusion-webui";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, flake-utils, stable_diffusion_webui_src, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
      in {
        devShells = rec {
          default = import ./shell.nix {
            inherit pkgs;
          };
        };
      }
  );
}
