# typed: ignore

module Maru
  module Commands
    Registry = CLI::Kit::CommandRegistry.new(default: "help")

    def self.register(const, cmd, path)
      autoload(const, path)
      Registry.add(->() { const_get(const) }, cmd)
    end

    register :Help,   "help",   "maru/commands/help"
    register :Flake,  "flake",  "maru/commands/flake"
    register :System, "system", "maru/commands/system"
  end
end
