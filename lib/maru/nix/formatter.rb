module Maru
  module Nix
    class Formatter < Output
      attr_reader :name

      def initialize(pkg_name)
        @name = pkg_name
      end

      def dependencies
        [ Maru::Nix::Input.nixpkgs_unstable ]
      end

      def to_nix(system)
        <<~NIX
          formatter.#{system} = ({ nixpkgs, ... }:
            with nixpkgs.legacyPackages.#{system}; #{@name}
          )
        NIX
      end
    end
  end
end
