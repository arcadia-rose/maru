# typed: strict

module Maru
  module Nix
    class Input
      extend T::Sig

      class << self
        extend T::Sig

        sig { returns(Input) }
        def nixpkgs_unstable
          new("nixpkgs", url: "github:nixos/nixpkgs/nixos-unstable")
        end
      end

      sig { returns(String) }
      attr_reader :name, :url

      sig { params(name: String, url: String).void }
      def initialize(name, url:)
        @name = T.let(name, String)
        @url = T.let(url, String)
      end

      sig { params(_system: String).returns(String) }
      def to_nix(_system)
        <<~NIX
        #{name} = {
          url = "#{url}";
        };
        NIX
      end
    end
  end
end
