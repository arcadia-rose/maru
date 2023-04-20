{
  "description" = "Main development environment for Rex";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { nixpkgs, ... }:
    let
      linux = "x86_64-linux";
      macos = "aarch64-darwin";
      macos-pkgs = nixpkgs.legacyPackages.${macos};
      linux-pkgs = nixpkgs.legacyPackages.${linux};

      common-packages = pkgs: with pkgs; [ ruby_3_1 ];
      macos-packages = with macos-pkgs; [ ];
      linux-packages = with linux-pkgs; [ ];

      macos-shell = macos-pkgs.mkShell {
        buildInputs = (common-packages macos-pkgs) ++ macos-packages;
        shellHook = ''
        '';
      };

      linux-shell = linux-pkgs.mkShell {
        buildInputs = (common-packages linux-pkgs) ++ linux-packages;
        shellHook = ''
        '';
      };
    in {
      packages.${macos}.default = [ ];
      packages.${linux}.default = [ ];
      devShells.${macos}.default = macos-shell;
      devShells.${linux}.default = linux-shell;
    };
}
