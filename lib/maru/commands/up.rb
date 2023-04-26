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

        File.open("flake.nix", "w") do |f|
          f.write(flake.to_nix(Maru::Nix::System.current))
        end

        puts CLI::UI.fmt("Wrote {{bold:flake.nix}}")

        if Maru::Nix::System.nixos?
          File.open(Maru::Nix::NixOS::Configuration::CONFIGURATION_NIX, "w") do |f|
            f.write(system.to_nix)
          end
          puts CLI::UI.fmt("Wrote {{bold:#{Maru::Nix::NixOS::Configuration::CONFIGURATION_NIX}}}")
        end
      end

      def self.help
        "Generate a {{bold:flake.nix}} for your project based on the configuration in {{bold:maru.rb}}."
      end
    end
  end
end
