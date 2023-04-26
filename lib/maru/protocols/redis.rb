module Maru
  module Protocols
    class Redis < Maru::Protocol
      autoload :Service, "maru/protocols/redis/service"

      class << self
        def latest(**kwargs)
          new(**kwargs)
        end
      end

      # TODO
      # Support all config
      # https://github.com/NixOS/nixpkgs/blob/nixos-unstable/nixos/modules/services/databases/redis.nix#L23
      def initialize(
        enable: true,
        user: "",
        bind: "127.0.0.1",
        port: 6379,
        logfile: "/dev/null"
      )
        @enable = enable
        @user = user
        @bind = bind
        @port = port
        @logfile = logfile
      end

      def services
        [ Service.new(enable: @enable, user: @user, bind: @bind, port: @port, logfile: @logfile) ]
      end
    end
  end
end
