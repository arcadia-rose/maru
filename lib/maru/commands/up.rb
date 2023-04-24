module Maru
  module Commands
    class Up < Maru::Command
      def call(args, _name)
        require_relative "../../../env"

        flake = Maru::Nix::Flake.new(outputs: Maru::Env.languages.flat_map(&:outputs))

        puts flake.to_nix("x86_64-linux")
      end

      def self.help
        "Generate a {{bold:flake.nix}} for your project based on the configuration in {{bold:env.rb}}."
      end
    end
  end
end
