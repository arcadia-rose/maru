require 'cli/ui'
require 'cli/kit'

CLI::UI::StdoutRouter.enable

module Maru
  TOOL_NAME = 'maru'
  ROOT      = File.expand_path('../..', __FILE__)
  LOG_FILE  = '/tmp/maru.log'

  autoload(:EntryPoint, 'maru/entry_point')
  autoload(:Commands,   'maru/commands')
  autoload :Language, "maru/language"
  
  Config = CLI::Kit::Config.new(tool_name: TOOL_NAME)
  Command = CLI::Kit::BaseCommand

  Executor = CLI::Kit::Executor.new(log_file: LOG_FILE)
  Resolver = CLI::Kit::Resolver.new(
    tool_name: TOOL_NAME,
    command_registry: Maru::Commands::Registry
  )

  ErrorHandler = CLI::Kit::ErrorHandler.new(log_file: LOG_FILE)

  module Nix
    autoload :DevShell, "maru/nix/dev_shell"
    autoload :Flake,    "maru/nix/flake"
    autoload :Input,    "maru/nix/input"
    autoload :Output,   "maru/nix/output"
  end

  module Languages
    autoload :Ruby, "maru/languages/ruby"
  end
end
