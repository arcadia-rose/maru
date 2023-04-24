module Maru
  module Nix
    class DevShell < Output
      def name
        "default"
      end

      def dependencies
        [ Maru::Nix::Input.nixpkgs_unstable ]
      end

      def legacy_packages
        []
      end
      
      def inputs
        []
      end

      def shell
        ""
      end

      def to_nix(system)
        <<~NIX
          devShells.#{system}.#{name} = ({ nixpkgs, ... }:
            let
              pkgs = nixpkgs.legacyPackages.#{system};
            in with pkgs; pkgs.mkShell {
              buildInputs = [ #{legacy_packages.join(" ") } ];
              inputsFrom = [ #{inputs.join(" ") } ];
              shellHook = ''
                #{shell}
              '';
            }
          )
        NIX
      end
    end
  end
end
