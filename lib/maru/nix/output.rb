# typed: strict

module Maru
  module Nix
    module Output
      extend T::Sig
      extend T::Helpers
      include Kernel

      interface!
     
      sig { abstract.returns(String) }
      def name; end

      sig { abstract.returns(T::Array[Maru::Nix::Input]) }
      def dependencies; end

      sig { abstract.params(_system: String).returns(String) }
      def to_nix(_system); end
    end
  end
end
