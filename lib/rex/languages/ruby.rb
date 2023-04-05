module Rex
  module Languages
    class Ruby < Language
      class << self
        def v3_1
          "ruby-3.1.2"
        end
      end

      def initialize(**kwargs)
        super
      end
    end
  end
end
