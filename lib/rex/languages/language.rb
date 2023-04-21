module Rex
  module Languages
    class Language < Rex::Flake
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
