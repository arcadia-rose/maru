module Maru
  module Nix
    module NixOS
      class Configuration < Maru::Nix::Output
        def initialize(hostname:, services: [])
          @hostname = hostname
          @services = services
        end

        def name
          @hostname
        end
        
        def dependencies
          [ Maru::Nix::Input.nixpkgs_unstable ]
        end

        def to_nix(_system)
          <<~NIX
          nixosConfigurations."#{name}" = ({ nixpkgs, self, ... }:
            nixpkgs.lib.nixosSystem {
              system = "#{Maru::Nix::System.nixos}";
              modules =
                [ ({ pkgs, ... }: {
                    boot.isContainer = false;
                    boot.loader.systemd-boot.enable=true;
                    fileSystem."/".device = "/dev/disk/by-label/nixos";
                    # Let `nixos-version --json` know about the Git revision of the flake.
                    system.configurationRevision = nixpkgs.lib.mkIf (self ? rev) self.rev;
                    networking.useDHCP = false;
                    networking.firewall.allowedTCPPorts = [ ];
                    services = {
                      #{@services.map(&:to_nix).join("\n")}
                    };
                  })
                ];
            }
          )
          NIX
        end
      end
    end
  end
end
