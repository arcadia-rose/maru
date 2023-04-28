# typed: strict

module Maru
  module Nix
    module DevShell
      class Merged
        extend T::Sig
        include DevShell

        sig { override.returns(String) }
        attr_reader :name

        sig { override.returns(T::Array[Maru::Nix::Input]) }
        attr_reader :dependencies

        sig { override.returns(T::Array[String]) }
        attr_reader :legacy_packages

        sig { override.returns(T::Array[String]) }
        attr_reader :inputs

        sig { override.returns(String) }
        attr_reader :shell

        sig do
          params(
            name: String,
            dependencies: T::Array[Maru::Nix::Input],
            legacy_packages: T::Array[String],
            inputs: T::Array[String],
            shell: String)
          .void
        end
        def initialize(
          name:,
          dependencies:,
          legacy_packages:,
          inputs:,
          shell:
        )
          @name = T.let(name, String)
          @dependencies = T.let(dependencies, T::Array[Maru::Nix::Input])
          @legacy_packages = T.let(legacy_packages, T::Array[String])
          @inputs = T.let(inputs, T::Array[String])
          @shell = T.let(shell, String)
        end
      end
    end
  end
end
