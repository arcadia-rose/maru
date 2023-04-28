# typed: strict

module Maru
  module Nix
    class Formatter
      extend T::Sig
      include Output

      sig { returns(String) }
      attr_reader :name

      sig { params(pkg_name: String).void }
      def initialize(pkg_name)
        @name = T.let(pkg_name, String)
      end

      sig { override.returns(T::Array[Input]) }
      def dependencies
        [ Maru::Nix::Input.nixpkgs_unstable ]
      end

      sig { override.params(system: String).returns(String) }
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
