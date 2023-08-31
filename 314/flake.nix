{
    description = "A nix flake for CS 314";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";
    };

    outputs = { self, nixpkgs, ... }: let
        system = "x86_64-linux";
    in {
        devShells."${system}".default = let
            pkgs = import nixpkgs {
                inherit system;
                config = {
                    permittedInsecurePackages = [
                        "openssl-1.1.1v"
                    ];
                };
                overlays = [
                    (final: prev: {
                        maven = prev.maven.overrideAttrs (old: {
                                    version = "3.9.4";
                                    src = builtins.fetchurl {
                                        url = "https://dlcdn.apache.org/maven/maven-3/3.9.4/binaries/apache-maven-3.9.4-bin.tar.gz";
                                        sha256 = "sha256:06c316ivxixs08wwjqd1z7g7292qgfijav2gshqx6f0ahc6bfrpz";
                                    };
                                });
                    })
                ];
                permittedInsecurePackages = [
                    "openssl-1.1.1v"
                ];
            };
        in pkgs.mkShell {
            packages = with pkgs; [
                jdk11
                maven
                mariadb_104
                nodejs_18
            ];

            shellHook = ''
                echo "Starting Dev Shell:::"
                exec zsh
            '';
        };
    };
}
