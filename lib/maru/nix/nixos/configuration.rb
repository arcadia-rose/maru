# typed: strict

module Maru
  module Nix
    module NixOS
      class Configuration
        extend T::Sig

        CONFIGURATION_NIX = "/etc/nixos/configuration.nix"

        sig { params(services: T::Array[Maru::Nix::Service]).void }
        def initialize(services: [])
          # TODO - Make hardcoded values configurable
          @services = T.let(services, T::Array[Maru::Nix::Service])
        end

        sig { returns(String) }
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
