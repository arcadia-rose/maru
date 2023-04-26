module Maru
  module Nix
    module NixOS
      class Configuration
        CONFIGURATION_NIX = "/etc/nixos/configuration.nix"

        def initialize(services: [])
          # TODO - Make hardcoded values configurable
          @services = services
        end

        def to_nix
          <<~NIX
            { ... }:
            let
              pkgs = import <nixpkgs> {};
            in {
              imports = [
                <nixpkgs/nixos/modules/virtualisation/google-compute-image.nix>
              ];
              environment = {
                systemPackages = with pkgs; [
                  vim
                  git
                  tree
                  ripgrep
                  fd
                ];
              };
              nix = {
                package = pkgs.nixFlakes;
                extraOptions = ''
                  experimental-features = nix-command flakes
                '';
              };
              services = {
                #{@services.map(&:to_nix).join("\n")}
              };
            }
          NIX
        end
      end
    end
  end
end
