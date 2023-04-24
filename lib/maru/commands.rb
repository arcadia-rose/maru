module Maru
  module Commands
    Registry = CLI::Kit::CommandRegistry.new(default: 'help')

    def self.register(const, cmd, path)
      autoload(const, path)
      Registry.add(->() { const_get(const) }, cmd)
    end

    register :Example, 'example', 'maru/commands/example'
    register :Help,    'help',    'maru/commands/help'
  end
end
