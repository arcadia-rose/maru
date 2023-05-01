module Maru
  module Commands
    class Flake < Maru::Command
      def call(args, _name)
        project = Maru::Project.current
        if project.nil?
          puts CLI::UI.fmt("The current project does not have a {{bold:maru.rb}} file")
          return
        end

        require_relative project.maru_rb

        flake = Maru::Nix::Flake.new(
          outputs: [
            Maru::Env.packages.outputs,
            Maru::Env.languages.flat_map(&:outputs),
          ].flatten
        )

        File.open("flake.nix", "w") do |f|
          f.write(flake.to_nix(Maru::Nix::System.current))
        end

        puts CLI::UI.fmt("Wrote {{bold:flake.nix}}")
      end

      def self.help
        "Generate a {{bold:flake.nix}} for your project based on the configuration in {{bold:maru.rb}}."
      end
    end
  end
end

