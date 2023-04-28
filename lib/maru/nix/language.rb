# typed: strict

module Maru
  module Nix
    module Language
      extend T::Sig
      
      sig { params(value: T.untyped).returns(String) }
      def self.format(value)
        case value
        when String
          "\"#{value}\""
        when Integer
          value.to_s
        # TODO - Support lists and sets
        else
          "#{value}"
        end
      end
    end
  end
end
