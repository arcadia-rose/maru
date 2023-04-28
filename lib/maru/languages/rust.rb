# typed: strict

module Maru
  module Languages
    class Rust
      extend T::Sig
      include Maru::Language

      autoload :DevShell, "maru/languages/rust/dev_shell"

      class << self
        extend T::Sig

        sig { returns(Rust) }
        def latest
          new
        end
      end

      sig { override.returns(T::Array[Maru::Nix::Output]) }
      def outputs
        [ DevShell.new ]
      end
    end
  end
end
