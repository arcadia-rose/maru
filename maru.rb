require 'maru'

module Maru
  module Env
    def self.languages
      [
        Maru::Languages::Ruby.v3_2,
        Maru::Languages::Rust.latest,
      ]
    end
  end
end
