module Maru
  module Nix
    class Output
      def name; ""; end
      def dependencies; []; end
      def to_nix(_system); ""; end
    end
  end
end
