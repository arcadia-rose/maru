# typed: strict

module Maru
  module Nix
    module Service
      extend T::Sig
      extend T::Helpers

      interface!

      sig { abstract.returns(String) }
      def name; end
      
      sig { abstract.returns(String) }
      def to_nix; end
    end
  end
end
