# typed: strict

module Maru
  module Nix
    class Flake
      extend T::Sig
      include Kernel

      sig { params(outputs: T::Array[Output], description: String).void }
      def initialize(
        outputs:,
        description: "A Nix Flake auto-generated by Maru"
      )
        @description = T.let(description, String)
        @inputs = T.let(outputs.flat_map(&:dependencies).uniq(&:name), T::Array[Input])
        @outputs = T.let(consolidate(outputs + default_outputs), T::Array[Output])
      end

      sig { params(system: String).returns(String) }
      def to_nix(system)
        <<~NIX
        {
          description = "#{@description}";

          inputs = {
            #{@inputs.map do |input|
              input.to_nix(system)
            end.join("\n")}
          };

          outputs = inputs: {
            #{@outputs.map do |output|
              output.to_nix(system) + " inputs;"
            end.join("\n")}
          };
        }
        NIX
      end

      private

      sig { params(outputs: T::Array[Output]).returns(T::Array[Output]) }
      def consolidate(outputs)
        dev_shells = outputs
          .select { |output| output.is_a?(Maru::Nix::DevShell) }
          .group_by(&:name)
          .values
          .map do |shells|
            shells.reduce do |shell, next_shell| 
              T.cast(shell, Maru::Nix::DevShell).merge(T.cast(next_shell, Maru::Nix::DevShell))
            end
          end

        others = outputs.reject { |output| output.is_a?(Maru::Nix::DevShell) }

        [ dev_shells, others ].flatten.map { |output| T.must(output) }
      end

      sig { returns(T::Array[Output]) }
      def default_outputs
        [ default_formatter ]
      end

      sig { returns(Maru::Nix::Formatter) }
      def default_formatter
        Maru::Nix::Formatter.new("nixfmt")
      end
    end
  end
end
