# typed: strict

module Maru
  module Nix
    module Services
      module Builtin
        extend T::Sig
        extend T::Helpers
        include Service

        abstract!

        sig { overridable.returns(T::Hash[Symbol, T.untyped]) }
        def config
          {}
        end

        sig { override.returns(String) }
        def to_nix
          <<~NIX
            #{name} = {
              #{config.map do |key, value|
              "#{key} = #{Maru::Nix::Language.format(value)};"
              end.join("\n")}
            };
          NIX
        end
      end
    end
  end
end
