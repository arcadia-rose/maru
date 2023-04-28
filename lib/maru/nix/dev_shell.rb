# typed: strict

module Maru
  module Nix
    module DevShell
      extend T::Sig
      extend T::Helpers
      include Output
      include Kernel

      abstract!

      autoload :Merged, "maru/nix/dev_shell/merged"

      sig { override.returns(String) }
      def name
        "default"
      end

      sig { override.returns(T::Array[Maru::Nix::Input]) }
      def dependencies
        [ Maru::Nix::Input.nixpkgs_unstable ]
      end

      sig { overridable.returns(T::Array[String]) }
      def legacy_packages
        []
      end
      
      sig { overridable.returns(T::Array[String]) }
      def inputs
        []
      end

      sig { overridable.returns(String) }
      def shell
        ""
      end

      sig { override.params(system: String).returns(String) }
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

      sig { overridable.params(other: Maru::Nix::DevShell).returns(Maru::Nix::DevShell) }
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
