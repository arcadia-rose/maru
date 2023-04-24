module Maru
  module Languages
    class Rust
      class DevShell < Maru::Nix::DevShell
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
