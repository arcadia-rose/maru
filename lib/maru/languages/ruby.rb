# typed: strict

module Maru 
  module Languages
    class Ruby
      extend T::Sig
      include Maru::Language

      autoload :DevShell, "maru/languages/ruby/dev_shell"

      class << self
        extend T::Sig

        sig { returns(Ruby) }
        def v3_2
          new("ruby_3_2")
        end
      end

      sig { params(version: String).void }
      def initialize(version)
        @version = T.let(version, String)
      end

      sig { override.returns(T::Array[Maru::Nix::Output]) }
      def outputs
        [ DevShell.new(@version) ]
      end
    end
  end
end
