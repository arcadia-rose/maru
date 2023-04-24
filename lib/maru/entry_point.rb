module Maru
  module EntryPoint
    def self.call(args)
      cmd, command_name, args = Maru::Resolver.call(args)
      Maru::Executor.call(cmd, command_name, args)
    end
  end
end

