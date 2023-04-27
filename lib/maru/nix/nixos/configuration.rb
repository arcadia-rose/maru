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
          []
        end

        def to_nix(_system)
          <<~NIX
          nixosConfigurations."#{name}" = {
            services = {
              #{@services.map(&:to_nix).join("\n")}
            };
          };
          NIX
        end
      end
    end
  end
end
