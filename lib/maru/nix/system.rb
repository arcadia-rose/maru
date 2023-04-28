# typed: strict

module Maru
  module Nix
    class System
      class << self
        extend T::Sig

        sig { returns(String) }
        def current
          return macos if macos?

          nixos
        end

        sig { returns(String) }
        def macos
          "aarch64-darwin"
        end

        sig { returns(T::Boolean) }
        def macos?
          `uname -a`.include?("Darwin")
        end

        sig { returns(String) }
        def nixos
          "x86_64-linux"
        end

        sig { returns(T::Boolean) }
        def nixos?
          `uname -a`.include?("NixOS")
        end
      end
    end
  end
end
