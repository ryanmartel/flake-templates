{
    description = "A basic nix flake for compiling C programs for CS 370";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";
    };

    outputs = { self, nixpkgs, ... }: let
        system = "x86_64-linux";
    in {
        devShells."${system}".default = let
            pkgs = import nixpkgs {
                inherit system;
                overlays = [];
            };
        in pkgs.mkShell {
            packages = with pkgs; [
                gnumake42
                gcc8
                valgrind
            ];

            shellHook = ''
                echo "Starting Dev Shell:::"
                exec zsh
            '';
        };
    };
}
