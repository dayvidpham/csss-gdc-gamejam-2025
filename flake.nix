{
  description = "Base configuration using flake to manage NixOS";

  # Inputs
  # https://nixos.org/manual/nix/unstable/command-ref/new-cli/nix3-flake.html#flake-inputs
  inputs = {
    #############################
    # NixOS-related inputs
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-25.05";

  };

  outputs =
    inputs@{ self
      # NixOS-related
    , nixpkgs
    , nixpkgs-unstable
    , nixpkgs-stable
    , ...
    }:
    let
      system = "x86_64-linux";
      nixpkgs-options = {
        inherit system;

        config = {
          allowUnfree = true;
          cudaSupport = true;
        };
      };

      pkgs = import nixpkgs nixpkgs-options;
      pkgs-unstable = import nixpkgs-unstable nixpkgs-options;
      pkgs-stable = import nixpkgs-stable nixpkgs-options;

      lib = pkgs.lib;

    in
    {
      devShells.${system}.default = pkgs.mkShell {
        packages = [
          pkgs.audacity
        ];
      };
    };
}
