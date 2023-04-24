module Maru 
  module Languages
    class Ruby < Maru::Language
      class << self
        def v3_1
          new("ruby_3_1")
        end
      end

      def initialize(package)
        @package = package
      end

      def packages
        [ @package ]
      end
    end
  end
end
