module Rex
  module Packages
    class Package
      attr_reader :version

      def initialize(version: '')
        @version = version
      end
    end
  end
end
