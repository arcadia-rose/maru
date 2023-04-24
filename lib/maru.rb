module Maru
  autoload :Language, "maru/language"

  module Nix
    autoload :DevShell, "maru/nix/dev_shell"
    autoload :Flake,    "maru/nix/flake"
    autoload :Input,    "maru/nix/input"
  end

  module Languages
    autoload :Ruby, "maru/languages/ruby"
  end
end
