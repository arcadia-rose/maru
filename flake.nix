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

      common-packages = pkgs: with pkgs; [ vim git ruby_3_1 ];

      macos-shell = {
        buildInputs = common-packages macos-pkgs;
        shellHook = ''
        '';
      };

      linux-shell = {
        buildInputs = common-packages linux-pkgs;
        shellHook = ''
        '';
      };
    in {
      packages.${macos}.default = [ ];
      packages.${linux}.default = [ ];
      devShells.${macos}.default = macos-pkgs.mkShell macos-shell;
      devShells.${linux}.default = linux-pkgs.mkShell linux-shell;
    };
}
