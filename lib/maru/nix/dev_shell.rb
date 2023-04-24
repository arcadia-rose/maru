module Maru
  module Nix
    class DevShell < Output
      autoload :Merged, "maru/nix/dev_shell/merged"

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

      def merge(other)
        raise RuntimeError, "Trying to merge DevShells with different names" if name != other.name

        Merged.new(
          name: name,
          dependencies: (dependencies + other.dependencies).uniq(&:name),
          legacy_packages: (legacy_packages + other.legacy_packages).uniq,
          inputs: (inputs + other.inputs).uniq,
          shell: (shell + "\n" + other.shell),
        )
      end
    end
  end
end
