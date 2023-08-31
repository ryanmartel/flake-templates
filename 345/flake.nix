{
    description = "A Nix-Flake for setting up Jupyter With common libraries.";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";
    };

    outputs = { self, nixpkgs, ... }: let 
        system = "x86_64-linux";
    in {
        devShells."${system}".default = let
            pkgs = import nixpkgs {
                inherit system;
                overlays = [
                    
                ];
            };
            python-packages = ps: with ps; [
                pandas
                matplotlib
                numpy
                scikit-learn
                tensorflow
            ];
        in pkgs.mkShell {
        # Create Environment
            packages = with pkgs; [
                jupyter
                (python3.withPackages python-packages)
            ];

            shellHook = ''
                echo "Starting Dev Shell:::"
                exec zsh
            '';
        };
    };
}
