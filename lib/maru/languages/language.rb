module Maru
  module Languages
    class Language < Maru::Flake
      def initialize(name:, legacy_packages:)
        @name = name
        @legacy_packages = legacy_packages
      end

      def apps(system)
        { @name => @legacy_packages }
      end
    end
  end
end
