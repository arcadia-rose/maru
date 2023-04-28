# typed: strict

module Maru
  module Languages
    class Ruby
      class DevShell
        extend T::Sig
        include Maru::Nix::DevShell

        sig { params(version: String).void }
        def initialize(version)
          @version = T.let(version, String)
        end

        sig { override.returns(T::Array[String]) }
        def legacy_packages
          [ @version ]
        end
      end
    end
  end
end
