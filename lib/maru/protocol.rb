# typed: strict

module Maru
  module Protocol
    extend T::Sig
    extend T::Helpers

    interface!

    sig { abstract.returns(T::Array[Maru::Nix::Service]) }
    def services; end
  end
end
