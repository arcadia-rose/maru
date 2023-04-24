module Maru
  module Languages
    class Rust < Maru::Language
      autoload :DevShell, "maru/languages/rust/dev_shell"

      class << self
        def latest
          new
        end
      end

      def outputs
        [ DevShell.new ]
      end
    end
  end
end
