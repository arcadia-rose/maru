# typed: strict

module Maru
  module Protocols
    class Redis
      extend T::Sig
      include Maru::Protocol

      autoload :Service, "maru/protocols/redis/service"

      class << self
        extend T::Sig

        sig { params(enable: T::Boolean, user: String, bind: String, port: Integer, logfile: String).void }
        def latest(
          enable: true,
          user: "",
          bind: "127.0.0.1",
          port: 6379,
          logfile: "/dev/null"
        )
          new(
            enable: true,
            user: "",
            bind: "127.0.0.1",
            port: 6379,
            logfile: "/dev/null",
          )
        end
      end

      # TODO
      # Support all config
      # https://github.com/NixOS/nixpkgs/blob/nixos-unstable/nixos/modules/services/databases/redis.nix#L23
      sig { params(enable: T::Boolean, user: String, bind: String, port: Integer, logfile: String).void }
      def initialize(
        enable: true,
        user: "",
        bind: "127.0.0.1",
        port: 6379,
        logfile: "/dev/null"
      )
        @enable = T.let(enable, T::Boolean)
        @user = T.let(user, String)
        @bind = T.let(bind, String)
        @port = T.let(port, Integer)
        @logfile = T.let(logfile, String)
      end

      sig { override.returns(T::Array[Maru::Nix::Service]) }
      def services
        [ Service.new(enable: @enable, user: @user, bind: @bind, port: @port, logfile: @logfile) ]
      end
    end
  end
end
