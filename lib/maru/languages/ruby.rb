module Maru 
  module Languages
    class Ruby < Maru::Language
      autoload :DevShell, "maru/languages/ruby/dev_shell"

      class << self
        def v3_2
          new("ruby_3_2")
        end
      end

      def initialize(version)
        @version = version
      end

      def outputs
        [ DevShell.new(@version) ]
      end
    end
  end
end
