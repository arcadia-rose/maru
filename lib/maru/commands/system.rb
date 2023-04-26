module Maru
  module Commands
    class System < Maru::Command
      def call(args, _name)
        project = Maru::Project.current
        if project.nil?
          puts CLI::UI.fmt("The current project does not have a {{bold:maru.rb}} file")
          return
        end

        require_relative project.maru_rb

        system = Maru::Nix::NixOS::Configuration.new(services: Maru::Env.protocols.flat_map(&:services))

        unless Maru::Nix::System.nixos?
          puts CLI::UI.fmt("It looks like you aren't running on NixOS.")
          return
        end

        File.open(Maru::Nix::NixOS::Configuration::CONFIGURATION_NIX, "w") do |f|
          f.write(system.to_nix)
        end
        puts CLI::UI.fmt("Wrote {{bold:#{Maru::Nix::NixOS::Configuration::CONFIGURATION_NIX}}}")
      end

      def self.help
        <<~HELP
        Generate a {{bold#{Maru::Nix::NixOS::Configuration::CONFIGURATION_NIX}}} based on
        the configuration in {{bold:maru.rb}}.
        HELP
      end
    end
  end
end

