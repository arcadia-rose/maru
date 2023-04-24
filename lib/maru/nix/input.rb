module Maru
  module Nix
    class Input
      class << self
        def nixpkgs_unstable
          new("nixpkgs", url: "github:nixos/nixpkgs/nixos-unstable")
        end
      end

      attr_reader :name, :url

      def initialize(name, url:)
        @name = name
        @url = url
      end

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
