module Maru
  module Languages
    class Ruby
      class DevShell < Maru::Nix::DevShell
        def initialize(version)
          @version = version
        end

        def legacy_packages
          [ @version ]
        end
      end
    end
  end
end
