module Maru
  module Nix
    class DevShell
      class Merged < DevShell
        attr_reader :name, :dependencies, :legacy_packages, :inputs, :shell

        def initialize(
          name:,
          dependencies:,
          legacy_packages:,
          inputs:,
          shell:
        )
          @name = name
          @dependencies = dependencies
          @legacy_packages = legacy_packages
          @inputs = inputs
          @shell = shell
        end
      end
    end
  end
end
