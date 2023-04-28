# typed: strict

module Maru
  module Languages
    class Rust
      class DevShell
        extend T::Sig
        include Maru::Nix::DevShell

        sig { override.returns(T::Array[String]) }
        def legacy_packages
          [
            "rustc",
            "rustfmt",
            "rustup",
            "cargo",
          ]
        end
      end
    end
  end
end
