# typed: strict

module Maru
  module Protocols
    class Redis
      class Service
        extend T::Sig
        include Maru::Nix::Services::Builtin

        sig { override.returns(T::Hash[Symbol, T.untyped]) }
        attr_reader :config

        sig { override.returns(String) }
        def name
          'redis.servers.""'
        end

      sig { params(enable: T::Boolean, user: String, bind: String, port: Integer, logfile: String).void }
        def initialize(
          enable: true,
          user: "",
          bind: "127.0.0.1",
          port: 6379,
          logfile: "/dev/null"
        )
          @config = T.let({
            enable:, user:, bind:, port:, logfile:
          }, T::Hash[Symbol, T.untyped])
        end
      end
    end
  end
end
