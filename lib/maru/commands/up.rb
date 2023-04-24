module Maru
  module Commands
    class Up < Maru::Command
      def call(args, _name)
        require_relative "../../../env"

        flake = Maru::Nix::Flake.new(outputs: Maru::Env.languages.flat_map(&:outputs))

        puts flake.to_nix("x86_64-linux")
      end

      def self.help
        "Example"
      end
    end
  end
end
