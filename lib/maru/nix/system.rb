module Maru
  module Nix
    class System
      class << self
        def current
          return macos if macos?

          nixos
        end

        def macos
          "aarch64-darwin"
        end

        def macos?
          `uname -a`.include?("Darwin")
        end

        def nixos
          "x86_64-linux"
        end

        def nixos?
          `uname -a`.include?("NixOS")
        end
      end
    end
  end
end
