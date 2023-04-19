CFG_FILE="/etc/nixos/configuration.nix"

CFG="
{ ... }:
let
  pkgs = import <nixpkgs> {};
in
{
  system = {
    stateVersion = "22.11";
  };
  imports = [
    <nixpkgs/nixos/modules/virtualisation/google-compute-image.nix>
  ];
  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };
}
"

function main() {
  OS_INFO="$(uname -a)";

  if [[ ! "NixOS" =~ .*"$OS_INFO".* ]]; then
    echo "This script is only intended to run in NixOS.";
    echo "Exiting...";
    exit
  fi

  if [ "$EUID" -ne 0 ]; then
    echo "Please run this script as root.";
    echo "Exiting...";
    exit
  fi

  echo "Writing configuration to $CFG_FILE";
  echo "  * Pinning stateVersion to 22.11";
  echo "  * Enabling flakes";
  echo "  * Enabling nix-command";

  # The real work happens here
  rm $CFG_FILE;
  echo "$CFG" > $CFG_FILE;
  nixos-rebuild switch

  echo "Done."
}

main
