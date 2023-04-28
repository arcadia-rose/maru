# typed: strict

module Maru
  module Language
    extend T::Sig
    extend T::Helpers

    interface!

    sig { abstract.returns(T::Array[Maru::Nix::Output]) }
    def outputs; end
  end
end
