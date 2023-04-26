module Maru
  module Protocols
    class Redis
      class Service < Maru::Nix::Services::Builtin
        attr_reader :config

        def name
          'redis.servers.""'
        end

        def initialize(**kwargs)
          @config = kwargs
        end
      end
    end
  end
end
