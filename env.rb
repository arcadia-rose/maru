require 'rex'

module Rex
  module Env
    def self.languages
      [ Rex::Languages::Ruby.v3_1 ]
    end
  end
end
