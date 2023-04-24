require 'maru'

module Maru
  module Env
    def self.languages
      [ Maru::Languages::Ruby.v3_1 ]
    end
  end
end
