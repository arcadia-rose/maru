require 'cli/ui'
require 'cli/kit'

CLI::UI::StdoutRouter.enable

module Maru
  TOOL_NAME = 'maru'
  ROOT      = File.expand_path('../..', __FILE__)
  LOG_FILE  = '/tmp/maru.log'

  autoload :Commands,   "maru/commands"
  autoload :EntryPoint, "maru/entry_point"
  autoload :Language,   "maru/language"
  autoload :Packages,   "maru/packages"
  autoload :Project,    "maru/project"
  autoload :Protocol,   "maru/protocol"
  
  Config = CLI::Kit::Config.new(tool_name: TOOL_NAME)
  Command = CLI::Kit::BaseCommand

  Executor = CLI::Kit::Executor.new(log_file: LOG_FILE)
  Resolver = CLI::Kit::Resolver.new(
    tool_name: TOOL_NAME,
    command_registry: Maru::Commands::Registry
  )

  ErrorHandler = CLI::Kit::ErrorHandler.new(log_file: LOG_FILE)

  module Nix
    module NixOS
      autoload :Configuration, "maru/nix/nixos/configuration"
    end

    autoload :DevShell,  "maru/nix/dev_shell"
    autoload :Flake,     "maru/nix/flake"
    autoload :Formatter, "maru/nix/formatter"
    autoload :Input,     "maru/nix/input"
    autoload :Language,  "maru/nix/language"
    autoload :Output,    "maru/nix/output"
    autoload :System,    "maru/nix/system"
    autoload :Service,   "maru/nix/service"
    autoload :Services,  "maru/nix/services"
  end

  module Languages
    autoload :Ruby, "maru/languages/ruby"
    autoload :Rust, "maru/languages/rust"
  end

  module Protocols
    autoload :Redis,  "maru/protocols/redis"
  end
end
