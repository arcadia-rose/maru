module Maru
  module Commands
    class Up < Maru::Command
      def call(args, _name)
        project = Maru::Project.current
        if project.nil?
          puts CLI::UI.fmt("The current project does not have a {{bold:maru.rb}} file")
          return
        end

        require_relative project.maru_rb

        flake = Maru::Nix::Flake.new(outputs: Maru::Env.languages.flat_map(&:outputs))
        system = Maru::Nix::NixOS::Configuration.new(services: Maru::Env.protocols.flat_map(&:services))

        puts flake.to_nix(Maru::Nix::System.current)
        puts "\n\n"
        puts system.to_nix
      end

      def self.help
        "Generate a {{bold:flake.nix}} for your project based on the configuration in {{bold:maru.rb}}."
      end
    end
  end
end
