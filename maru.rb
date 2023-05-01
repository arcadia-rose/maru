require 'maru'

module Maru
  module Env
    def self.packages
      Maru::Packages.new([
        "bat",
      ])
    end

    def self.languages
      [
        Maru::Languages::Ruby.v3_2,
        Maru::Languages::Rust.latest,
      ]
    end

    def self.protocols
      [ Maru::Protocols::Redis.latest ]
    end
  end
end
